import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/model/report_model.dart';

class ReportController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final RxString reportType = 'Incident'.obs;

  final RxList<ReportModel> reports = <ReportModel>[].obs;

  void clearFields() {
    txtTitle.clear();
    txtDescription.clear();
    reportType.value = 'Incident';
  }

  @override
  void onInit() {
    super.onInit();
    listenToReports();
  }

  // fetching all report - stream
  void listenToReports() {
    _firestore
        .collection('reports')
        .orderBy('reportedDate', descending: true)
        .snapshots()
        .listen((snapshot) {
      reports.value = snapshot.docs
          .map((doc) => ReportModel.fromFirebase(doc.data(), doc.id))
          .toList();
    });
  }

  // ➕ Add report
  Future<void> addReport({
    required String type,
    required String title,
    required String description,
    required String reportedBy,
  }) async {
    if (txtTitle.text.isNotEmpty && txtDescription.text.isNotEmpty) {
      try {
        final result = await _firestore.collection('reports').add({
          'type': type,
          'title': title,
          'description': description,
          'reportedBy': reportedBy,
          'reportedDate': DateTime.now(),
          'status': 'Pending',
          'resolutionDetails': null,
        });

        if (result.id.isNotEmpty) {
          log("SUCCESS: report added.");
          Get.back();
          clearFields();
        }
      } catch (e) {
        log("ERROR: adding report!");
      }
    } else {
      Get.snackbar(
        "Validation",
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
        shouldIconPulse:
        false,
      );
    }
  }

  // Mark as resolved
  Future<void> markAsResolved(String reportId, String resolutionDetails) async {
    try{
      await _firestore.collection('reports').doc(reportId).update({
        'status': 'Resolved',
        'resolutionDetails': resolutionDetails,
      });
      Get.back();
    } catch(e){
      log("ERROR: resolve error!");
    }
  }
}
