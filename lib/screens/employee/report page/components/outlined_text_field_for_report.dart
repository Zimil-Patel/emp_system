import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/app_theme.dart';

Widget outlinedTextFieldForReport({
  required String hintText,
  IconData? icon,
  required TextEditingController controller,
  int maxLine = 1,
  int minLine = 1,
  TextInputType type = TextInputType.text,
}) {

  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: TextField(
      controller: controller,
      keyboardType: type,
      cursorColor: primaryColor,
      maxLines: maxLine,
      minLines: minLine,
      textInputAction: TextInputAction.next,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        prefixIcon:
        icon != null ? Icon(icon, color: Colors.grey.shade400) : null,
        label: Text(hintText, style: TextStyle(color: Colors.grey)),
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
