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
  var filteredList = <AttendanceData>[].obs;

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
  Future<List<AttendanceData>> fetchAttendance(DateTime selectedDate) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    List<AttendanceData> records = [];

    final employeeSnapshot = await _firestore.collection('employees').get();

    // Build a list of futures for parallel execution
    final futures = employeeSnapshot.docs.map((doc) async {
      String name = doc['name'];
      String id = doc['employee_id'];
      String department = doc['department'];

      final checkInDoc = await doc.reference
          .collection('checkIns')
          .doc(formattedDate)
          .get();

      if (checkInDoc.exists) {
        return AttendanceData.fromFirestore(
          checkInDoc.data() as Map<String, dynamic>,
          name,
          id,
          department,
        );
      }
      return null;
    }).toList();

    // Wait for all future calls to complete
    final resultList = await Future.wait(futures);

    // Filter out null values (no attendance record)
    records = resultList.whereType<AttendanceData>().toList();

    // Apply filter
    if (filter.value == "Early") {
      filteredList.value = records.where((e) => e.isEarly).toList();
    } else if (filter.value == "Late") {
      filteredList.value = records.where((e) => e.isLate).toList();
    } else {
      filteredList.value = records;
    }

    return filteredList;
  }

  // Fetch employees in real-time
  void fetchEmployeeList() {
    _firestore.collection('employees').orderBy('createdAt', descending: true).snapshots().listen((querySnapshot) {
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
