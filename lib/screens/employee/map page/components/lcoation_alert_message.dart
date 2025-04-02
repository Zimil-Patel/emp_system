import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocationAlertMessage extends StatelessWidget {
  const LocationAlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          RichText(
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Note: ',
                  style: TextStyle(
                    fontFamily: 'VarelaRounded',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.h,
                  ),
                ),
                TextSpan(
                  text: 'Please go inside Office range then',
                  style: TextStyle(
                    fontFamily: 'VarelaRounded',
                    color: Colors.black,
                    fontSize: 12.h,
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            child: Text(
              'try again!',
              style: TextStyle(
                fontFamily: 'VarelaRounded',
                decoration: TextDecoration.underline,
                color: Colors.red.shade400,
                fontSize: 15.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
