import 'dart:developer';

import 'package:emp_system/controllers/auth_controller.dart';
import 'package:emp_system/core/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '../core/services/api_services.dart';

class ProfileController extends GetxController {
  final fbService = FirebaseServices.fbServices;
  final authController = Get.find<AuthController>();
  RxString image = "".obs;

  var isEditing = false.obs;

  var txtName = TextEditingController();
  var txtDesignation = TextEditingController();
  var txtDepartment = TextEditingController();
  var txtTeamName = TextEditingController();
  var txtPhone = TextEditingController();

  void setUpFields() {
    if (authController.currentEmployee != null) {
      log("Setting up fields");
      var emp = authController.currentEmployee!;
      image.value = authController.currentEmployee!.photoUrl;
      txtName.text = emp.name;
      txtDesignation.text = emp.designation;
      txtDepartment.text = emp.department;
      txtTeamName.text = emp.teamName;
      txtPhone.text = emp.phone;
    }
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  Future<void> updateProfile() async {
    if (authController.currentEmployee == null) return;

    String email = authController.currentEmployee!.email;

    bool status = await fbService.updateEmployeeProfileDetails(
      email: email,
      name: txtName.text,
      designation: txtDesignation.text,
      department: txtDepartment.text,
      teamName: txtTeamName.text,
      phone: txtPhone.text,
    );

    if (status) {
      var refreshedEmployee =
          await fbService.getCurrentEmployeeProfileDetails(email);
      authController.currentEmployee = refreshedEmployee;
      isEditing.value = false;
      update();
      Get.snackbar(
        'Profile Updated',
        'Your profile has been updated successfully!',
        backgroundColor: Colors.blue.shade800,
        colorText: Colors.white,
        icon: Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 28,
        ),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 3),
        shouldIconPulse: false,
      );
    } else {
      Get.snackbar(
        'Update Failed',
        'Could not update profile. Please try again.',
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
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

  // PICK IMAGE
  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? data = await picker.pickImage(source: ImageSource.gallery);
    try {
      final Uint8List byteImage = await data!.readAsBytes();
      log("image pick success...");
      String url = await ApiServices.apiServices.postImage(byteImage) ?? "";
      if (url.isEmpty) return;

      final status = await fbService.updateEmployeeProfilePhoto(
          url, authController.currentEmployee!.email);

      if (!status) return;

      image.value = url;
      log("IMAGE URL: $image");
    } catch (e) {
      log("image pick failed!!!");
    }
  }
}
