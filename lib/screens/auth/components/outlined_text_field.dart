import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';

// OUTLINE TEXT FIELD
Widget outlinedTextField(
    {required String hintText, IconData? icon,
    required TextEditingController controller}) {

  bool isPassword = hintText == 'Password';

  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: TextField(
      controller: controller,
      cursorColor: primaryColor,
      obscureText: isPassword ? true : false,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        suffixIcon:  isPassword ? IconButton(
          onPressed: () {},
          icon: Icon(Icons.remove_red_eye, color: Colors.grey.shade400,),
        ) : null,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade400) : null,
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
  );
}
