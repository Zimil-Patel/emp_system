// SHOW WAIT FOR VERIFICATION ALERT
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showVerificationAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.h),
      ),
      title: Row(
        children: [
          Text('Sign Up Complete'),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.red.shade400,
                ),
              ),
              child: Icon(
                Icons.close,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // MAIL ICON
          Image.asset(
            'assets/images/email_logo.png',
            height: 40.h,
            width: 40.w,
          ),

          SizedBox(
            height: 20.h,
          ),

          // DIALOG MESSAGE
          Text('Wait for verification! After Verify you will get a email'),
        ],
      ),
    ),
  );
}
