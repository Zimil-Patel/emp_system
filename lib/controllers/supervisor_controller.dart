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
  var attendanceList = <AttendanceData>[].obs;
  var filteredList = <AttendanceData>[].obs;

  RxList<EmployeeModel> employeeList = <EmployeeModel>[].obs;

  @override
  void onInit() {
    fetchEmployeeList();
    fetchAttendance();
    super.onInit();
  }

  updateDate(DateTime dateTime){
    selectedDate.value = dateTime;
    fetchAttendance();
  }

  // FETCH attendance records for selected date
  void fetchAttendance() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);

    FirebaseFirestore.instance.collection('employees').snapshots().listen((snapshot) async {
      List<AttendanceData> records = [];

      for (var doc in snapshot.docs) {
        String name = doc['name'];
        String id = doc['employee_id'];
        var checkIns = await doc.reference
            .collection('checkIns')
            .doc(formattedDate)
            .get();

        if (checkIns.exists) {
          records.add(AttendanceData.fromFirestore(checkIns.data()!, name, id));
        }
      }

      attendanceList.assignAll(records);
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
            '📧 Verification email has been sent to:\n$email',
            icon: Icon(Icons.email_outlined, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(12),
            borderRadius: 10,
            padding: EdgeInsets.all(12),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      }
    }
  }
}
