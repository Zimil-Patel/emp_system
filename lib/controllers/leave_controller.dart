import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/model/leave_model.dart';
import '../utils/constants.dart';

class LeaveController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<LeaveModel> allLeaves = <LeaveModel>[].obs;


  RxString selectedStatus = 'Approved'.obs;
  RxString selectedLeaveType = 'Sick Leave'.obs;
  final TextEditingController txtReason = TextEditingController();


  DateTime? fromDate;
  DateTime? toDate;

  // Reset fields
  void resetFields() {
    selectedStatus.value = 'Approved';
    fromDate = null;
    toDate = null;
    txtReason.clear();
    selectedLeaveType.value = "Sick Leave";
  }

  // Real-time stream of leaves
  Stream<List<LeaveModel>> getLeaveStream() {
    return _firestore
        .collection('leaves')
        .orderBy('fromDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LeaveModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add leave request
  Future<void> addLeave() async {
    // IF SOME FIELD IS MISSING SHOW WARING
    if (fromDate == null || toDate == null || txtReason.text.trim().isEmpty) {
      Get.snackbar(
        "Missing Info",
        "Please enter report details",
        backgroundColor: Colors.orange.shade700,
        colorText: Colors.white,
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
          size: 28,
        ),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 3),
        shouldIconPulse: false,
      );
      return;
    }

    // IF NOT THEN ADD LEAVE
    final employee = authController.currentEmployee!;
    final newLeave = LeaveModel(
      id: '',
      email: employee.email,
      employeeId: employee.employeeId,
      employeeName: employee.name,
      leaveType: selectedLeaveType.value,
      fromDate: fromDate!,
      toDate: toDate!,
      reason: txtReason.text.trim(),
      status: 'Pending',
      remarks: null,
    );

    try {
      final result =
          await _firestore.collection('leaves').add(newLeave.toMap());
      if (result.id.isNotEmpty) {
        log("SUCCESS: added");
        Get.back();
      }
    } catch (e) {
      log("ERROR: Adding leave request");
    }
  }

  // Accept or Reject leave
  Future<void> reviewLeave({
    required String leaveId,
    required String status,
    String? remarks,
  }) async {
    await _firestore.collection('leaves').doc(leaveId).update({
      'status': status,
      'remarks': remarks,
    });
  }
}
