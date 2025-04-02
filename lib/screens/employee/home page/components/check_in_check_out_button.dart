import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../map page/map_page.dart';

class CheckInCheckOutButton extends StatelessWidget {
  const CheckInCheckOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var gradientList = [
      Colors.grey.shade100,
      Colors.grey.shade100,
      Colors.grey.shade100,
      Colors.white,
      Colors.white,
      Colors.white,
    ];

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Get.to(() => MapPage());
        if (!attendanceController.hasCheckedIn.value) {
          Get.to(() => MapPage(isCheckIn: true));
        } else {
          Get.to(() => MapPage(isCheckIn: false));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1), // White at center
              Color.fromRGBO(255, 255, 255, 1), // White at 35%
              Color.fromRGBO(150, 150, 150, 1), // Light gray at edge
            ],
            stops: [0.0, 0.38, 1.0], // Define color transitions
            center: Alignment.center,
            radius: 1.0, // Full radial coverage
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 0.5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 68.h,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 110.h,
            width: 110.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientList,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Container(
              height: 90.h,
              width: 90.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: gradientList,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 0.5,
                      spreadRadius: 1),
                ],
              ),
              child: Obx(
                () => attendanceController.hasCheckedIn.value
                    ? ButtonContent(
                        imageName: 'click_red',
                        label: 'Check Out',
                        color: Colors.red.shade400,
                      )
                    : ButtonContent(
                        imageName: 'click_green',
                        label: 'Check In',
                        color: primaryColor,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonContent extends StatelessWidget {
  const ButtonContent(
      {super.key,
      required this.imageName,
      required this.label,
      required this.color});

  final String imageName, label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/$imageName.png',
          height: 28.h,
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.h,
            color: color,
          ),
        )
      ],
    );
  }
}
