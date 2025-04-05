import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';
import '../role_option_page.dart';

void showLogoutDialog() {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      title: Text(
        "Logout",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Are you sure you want to logout?",
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(), // Close dialog
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.back();
            await authController.signOut();
            Get.offAll(() => RoleOptionPage());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            "Logout",
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
