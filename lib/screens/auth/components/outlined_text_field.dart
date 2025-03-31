import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';

// OUTLINE TEXT FIELD
Widget outlinedTextField(
    {required String hintText,
    IconData? icon,
    required TextEditingController controller,
    bool enabled = true,
    TextInputType type = TextInputType.text}) {
  bool isPassword = hintText == 'Password';

  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: TextField(
      controller: controller,
      keyboardType: type,
      cursorColor: primaryColor,
      obscureText: isPassword ? true : false,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        prefixIcon:
            icon != null ? Icon(icon, color: Colors.grey.shade400) : null,
        label: Text(
          hintText,
          style: TextStyle(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    ),
  );
}

Widget outlinedTextFieldForPassword(
    {required String hintText,
    IconData? icon,
    required TextEditingController controller}) {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Obx(
      () => TextField(
        controller: controller,
        cursorColor: primaryColor,
        obscureText: authController.showPass.value,
        textInputAction: TextInputAction.done,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              authController.showPass.toggle();
            },
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.grey.shade400,
            ),
          ),
          prefixIcon:
              icon != null ? Icon(icon, color: Colors.grey.shade400) : null,
          label: Text(
            hintText,
            style: TextStyle(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
        ),
      ),
    ),
  );
}
