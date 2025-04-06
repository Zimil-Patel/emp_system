import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final txtCurrentPass = TextEditingController();
  final txtNewPass = TextEditingController();
  final txtConfirmPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isGoogleUser = false;

  @override
  void initState() {
    super.initState();
    checkProvider();
  }

  void checkProvider() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      for (var info in user.providerData) {
        if (info.providerId == 'google.com') {
          setState(() => isGoogleUser = true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: isGoogleUser
            ? Center(
          child: Text(
            "You signed in using Google.\nPassword change is not available.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.h, color: Colors.grey[700]),
          ),
        )
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              Text(
                "Enter your current and new password below.",
                style: TextStyle(fontSize: 14.h),
              ),
              SizedBox(height: 20.h),

              // CURRENT PASS
              TextFormField(
                controller: txtCurrentPass,
                obscureText: true,
                decoration: _fieldDecoration("Current Password"),
                onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                validator: (val) => val!.isEmpty ? "Enter current password" : null,
              ),
              SizedBox(height: 20.h),

              // NEW PASSWORD
              TextFormField(
                controller: txtNewPass,
                obscureText: true,
                decoration: _fieldDecoration("New Password"),
                onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                validator: (val) => val!.length < 6 ? "Password must be 6+ characters" : null,
              ),
              SizedBox(height: 20.h),


              // CONFIRM PASSWORD
              TextFormField(
                controller: txtConfirmPass,
                obscureText: true,
                decoration: _fieldDecoration("Confirm Password"),
                onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                validator: (val) => val != txtNewPass.text ? "Passwords do not match" : null,
              ),
              SizedBox(height: 30.h),

              // UPDATE PASSWORD BUTTON
              Obx(
                  () => ElevatedButton(
                  onPressed: authController.isLoading.value ? null : (){
                    if (_formKey.currentState!.validate()) {
                      authController.changePassword(currentPassword: txtCurrentPass.text, newPassword: txtNewPass.text);
                    }
                  },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text("Update Password", style: TextStyle(fontSize: 14.h, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_fieldDecoration(String hintText){
  return InputDecoration(
    labelText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(width: 2, color: primaryColor),
    ),

  );
}
