import 'package:emp_system/screens/auth/components/outlined_text_field.dart';
import 'package:emp_system/screens/supervisor/home%20page/supervisor_home_page.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

class SupervisorSignInPage extends StatelessWidget {
  const SupervisorSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var txtEmail = TextEditingController();
    var txtPass = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // WELCOME TAGLINES
                Text(
                  'Welcome Back! \n"Your Workforce, Your Control"',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.h),
                ),

                // LOGO
                Center(
                    child: Image.asset(
                  'assets/images/supervisorWork.png',
                  height: 240.h,
                  width: double.infinity,
                )),

                // EMAIL
                outlinedTextField(
                    hintText: 'Email', icon: Icons.email, controller: txtEmail),

                // PASSWORD
                outlinedTextFieldForPassword(
                    hintText: 'Password', icon: Icons.lock, controller: txtPass),

                // FORGOT PASSWORD
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showUnavailableResetPasswordDialog(context);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 13.h,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // SIGN IN BUTTON
                SizedBox(
                  height: 42.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () async {
                      final result = await authController.signInSupervisor(
                          txtEmail.text, txtPass.text);
                      if (result) Get.offAll(() => SupervisorHomePage());
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// SHOW RESET PASSWORD OPTION NOT AVAILABLE
showUnavailableResetPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.h),
      ),
      title: Row(
        children: [
          Icon(
            Icons.lock,
            color: primaryColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text('Reset Unavailable'),
        ],
      ),
      content: Text(
          'Password reset is not available for Supervisor accounts. Supervisor credentials are managed internally.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: TextStyle(color: primaryColor),
          ),
        ),
      ],
    ),
  );
}
