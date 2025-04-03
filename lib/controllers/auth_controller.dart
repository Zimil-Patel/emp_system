import 'dart:developer';

import 'package:emp_system/core/model/employee_model.dart';
import 'package:emp_system/core/services/auth_services.dart';
import 'package:emp_system/core/services/firebase_services.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth/components/verification_dialog.dart';

class AuthController extends GetxController {
  final auth = AuthServices.authServices;
  final fbService = FirebaseServices.fbServices;
  EmployeeModel? currentEmployee;

  RxBool isLoading = false.obs;
  RxBool showPass = false.obs;

  // Toggle showPass
  void togglePass() {
    showPass.value = !showPass.value;
  }

  // Sign-Up Employee
  Future<bool> signUpEmployee(
      String name, String email, String password, BuildContext context) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Sign-Up Failed!",
        "All Field are required",
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
      return false;
    }

    isLoading.value = true;

    var result = await auth.signUpEmployeeWithEmailPassword(email, password);
    if (result.$1 != null) {
      final status = await auth.addEmployeeToDatabase(email, name);

      if (status == "success") {
        showVerificationAlert(context);
        isLoading.value = false;
        return true;
      } else {
        Get.snackbar(
          "Sign-Up Failed!",
          status,
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
        isLoading.value = false;
        return false;
      }
    } else {
      Get.snackbar(
        "Sign-Up Failed!",
        result.$2,
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
      isLoading.value = false;

      return false;
    }
  }

  // Sign-in Employee
  Future<bool> signInEmployee(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Sign-In Failed!",
        "Please enter email and password",
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
      return false;
    }

    isLoading.value = true;

    final result = await auth.signInEmployeeWithEmailPassword(
        email: email, password: password);

    if (result.$1 != null) {
      final isVerified = await auth.checkIsEmployeeVerified(email);

      if (isVerified) {
        log("SUCCESS: Sign in.");
        await setCurrentUser('employee');
        currentEmployee =
            await fbService.getCurrentEmployeeProfileDetails(email);
        profileController.setUpFields();
        await attendanceController.checkTodayAttendance();
        log("Employee Name : ${profileController.txtName.text}");
        isLoading.value = false;
        await Future.delayed(Duration(seconds: 2), () => true);
        return true;
      } else {
        Get.snackbar(
          "Verification Pending!",
          "Once you get verified, you can log in.",
          backgroundColor: Colors.orange.shade700,
          colorText: Colors.white,
          icon: Icon(
            Icons.info,
            color: Colors.white,
            size: 28,
          ),
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(12),
          borderRadius: 8,
          duration: Duration(seconds: 3),
          shouldIconPulse: false,
        );
        log("FAILED: Not verified yet.");
        await auth.signOut();
        isLoading.value = false;
        return false;
      }
    } else {
      Get.snackbar(
        "Sign-In Failed!",
        result.$2,
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
      isLoading.value = false;
      return false;
    }
  }

  // Sign in with google
  Future<bool> handleGoogleSignIn(BuildContext context) async {
    isLoading.value = true;
    User? user = await auth.signInWithGoogle();

    if (user != null) {
      final isNewUser = await auth.isNewUser(user.email!);

      // Add employee data to database if new user and show verification alter
      if (isNewUser) {
        final status =
            await auth.addEmployeeToDatabase(user.email!, user.displayName!);
        if (status == "success") {
          isLoading.value = false;
          showVerificationAlert(context);
          return false;
        }
      } else {
        final isVerified = await auth.checkIsEmployeeVerified(user.email!);

        if (isVerified) {
          await setCurrentUser('employee');
          currentEmployee =
              await fbService.getCurrentEmployeeProfileDetails(user.email!);
          profileController.setUpFields();
          await attendanceController.checkTodayAttendance();
          log("Employee Name : ${profileController.txtName.text}");
          Future.delayed(Duration(seconds: 2), () => true);
          isLoading.value = false;
          return true;
        } else {
          Get.snackbar(
            'Verification Pending!',
            'Once you get verified, you can log in.',
            icon: Icon(Icons.info, color: Colors.white),
            backgroundColor: Colors.orange.shade700,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
          await auth.signOut();
          isLoading.value = false;
          return false;
        }
      }
    }

    isLoading.value = false;
    return false;
  }

  // Sign in supervisor
  Future<bool> signInSupervisor(String email, String password) async {
    if (email == supervisorEmail && password == supervisorPassword) {
      await setCurrentUser('supervisor');
      supervisorController.fetchEmployeeList();
      return true;
    } else {
      Get.snackbar(
        "Sign-Up Failed!",
        'Invalid email or password',
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
      return false;
    }
  }

  // Check user role on application start
  Future<String?> checkUserRole() async {
    try {
      final pref = await SharedPreferences.getInstance();
      return pref.getString('user_role');
    } catch (e) {
      log("ERROR: $e");
      return null;
    }
  }

  // Set current user
  Future<void> setCurrentUser(String role) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('user_role', role);

    if (role != "employee") {
      currentEmployee = null;
    }
  }

  // Get current user
  Future<void> getCurrentUser() async {
    final email = auth.getCurrentEmployeeEmail();

    if (email == null) return;

    currentEmployee = await fbService.getCurrentEmployeeProfileDetails(email);
  }

  // Sign out employee or supervisor
  Future<void> signOut() async {
    await auth.signOut();
    currentEmployee = null;
    await setCurrentUser('not found');
  }
}
