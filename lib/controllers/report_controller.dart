import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxString reportType = 'incident'.obs;

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    reportType.value = 'incident';
  }
}
