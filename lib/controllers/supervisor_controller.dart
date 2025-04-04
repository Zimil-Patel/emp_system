import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_system/core/model/employee_model.dart';
import 'package:emp_system/core/services/auth_services.dart';
import 'package:emp_system/core/services/mail_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/model/attendace_model.dart';

class SupervisorController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices auth = AuthServices.authServices;
  var selectedDate = DateTime.now().obs;
  var filter = "All".obs;

  RxList<EmployeeModel> employeeList = <EmployeeModel>[].obs;

  void updateDate(DateTime dateTime) {
    selectedDate.value = dateTime;
    update(['date']);
  }

  void setFilter(String value){
    selectedDate.value = DateTime.now();
    filter.value = value;
  }

  // FETCH attendance records for selected date
  Stream<List<AttendanceData>> fetchAttendanceStream(DateTime selectedDate) async* {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    yield* _firestore.collection('employees').snapshots().asyncMap((snapshot) async {
      List<AttendanceData> records = [];

      for (var doc in snapshot.docs) {
        String name = doc['name'];
        String id = doc['employee_id'];
        String department = doc['department'];

        DocumentSnapshot checkInDoc = await doc.reference.collection('checkIns').doc(formattedDate).get();

        if (checkInDoc.exists) {
          records.add(AttendanceData.fromFirestore(checkInDoc.data() as Map<String, dynamic>, name, id, department));
        }
      }

      if(filter.value == "Early"){
        return records.where((e) => e.isEarly).toList();
      } else if(filter.value == "Late"){
        return records.where((e) => e.isLate).toList();
      }
      return records;
    });
  }

  // Fetch employees in real-time
  void fetchEmployeeList() {
    _firestore.collection('employees').snapshots().listen((querySnapshot) {
      employeeList.value = querySnapshot.docs
          .map((doc) => EmployeeModel.fromFirestore(doc))
          .toList();
    });
  }

  // Update employee verification status
  Future<void> approveEmployeeRequest({required String email, required bool value, required String employeeId}) async {
    final result = await auth.approveEmployee(
        email: email, value: value, employeeId: employeeId);
    if (value) {
      if (result) {
        final isSent =
            await MailServices.mailServices.sendVerificationMail(email);
        if (isSent) {
          Get.snackbar(
            'Mail Sent Successfully!',
            'Verification email has been sent to:\n$email',
            backgroundColor: Colors.blue.shade800,
            colorText: Colors.white,
            icon: Icon(
              Icons.email,
              color: Colors.white,
              size: 28,
            ),
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(12),
            borderRadius: 8,
            duration: Duration(seconds: 3),
            shouldIconPulse: false,
          );
        }
      }
    }
  }
}
