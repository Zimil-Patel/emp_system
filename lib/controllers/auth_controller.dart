import 'dart:developer';

import 'package:emp_system/core/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/components/verification_dialog.dart';

class AuthController extends GetxController {
  final auth = AuthServices.authServices;

  RxBool isLoading = false.obs;
  RxBool showPass = false.obs;

  // Toggle showPass
  void togglePass() {
    showPass.value = !showPass.value;
  }

  // Sign-Up Employee
  Future<bool> signUpEmployee(String name, String email, String password, BuildContext context) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Sign-Up Failed!',
        'All Field are required',
        icon: Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
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
          'Sign-Up Failed!',
          status,
          icon: Icon(Icons.error, color: Colors.white),
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
        return false;
      }
    } else {
      Get.snackbar(
        "Sign Up Failed!", // Title
        result.$2, // Description
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
        duration: Duration(seconds: 3),
      );
      isLoading.value = false;

      return false;
    }
  }

  // Sign-in Employee
  Future<bool> signInEmployee({required String email, required String password}) async {

    if(email.isEmpty || password.isEmpty){
      Get.snackbar(
        'Sign-In Failed!',
        'Please enter email and password',
        icon: Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    isLoading.value = true;

    final result = await auth.signInEmployeeWithEmailPassword(email: email, password: password);

    if(result.$1 != null){

      final isVerified = await auth.checkIsEmployeeVerified(email);

      if(isVerified){
        log("SUCCESS: Sign in.");
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
        log("FAILED: Not verified yet.");
        await auth.signOut();
        isLoading.value = false;
        return false;
      }

    } else {
      Get.snackbar(
        "Sign In Failed!", // Title
        result.$2, // Description
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
        duration: Duration(seconds: 3),
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
      await auth.addEmployeeToDatabase(user.email!, user.displayName!);

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
  bool signInSupervisor(String email, String password){
    if(email == "admin@gmail.com" && password == "admin"){
      return true;
    } else {
      Get.snackbar(
        'Sign-In Failed!',
        'Invalid email or password',
        icon: Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
}
