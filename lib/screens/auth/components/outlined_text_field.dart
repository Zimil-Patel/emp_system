import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_theme.dart';


// OUTLINE TEXT FIELD
Widget outlinedTextField({required String hintText,required IconData icon, required TextEditingController controller}){
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: TextField(
      controller: controller,
      cursorColor: primaryColor,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey.shade400),
        label: Text(hintText, style: TextStyle(color: Colors.grey),),
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