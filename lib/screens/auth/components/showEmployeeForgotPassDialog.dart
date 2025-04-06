import 'package:emp_system/screens/employee/report%20page/components/outlined_text_field_for_report.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';

void showForgotPasswordDialog() {
  final txtEmail = TextEditingController();

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TITLE
            Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 18.h,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 15.h),

            // MESSAGE
            Text(
              "Enter your registered email address below. We'll send you a password reset link to your inbox.",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 15.h),

            // TEXT FIELD TO ENTER PASSWORD
            outlinedTextFieldForReport(hintText: 'Email', controller: txtEmail, type: TextInputType.emailAddress),
            SizedBox(height: 20.h),

            // CANCEL SEND BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                // CANCEL
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 14.h),
                  ),
                ),
                SizedBox(width: 10.w),


                // SEND
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  ),
                  onPressed: () async {
                    final email = txtEmail.text.trim();
                    await authController.sendPasswordResetEmail(email);
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(color: Colors.white, fontSize: 14.h),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
