import 'dart:math';

import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimingInfoRow extends StatelessWidget {
  const TimingInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
          () => ClockIconBox(
              angle: 135,
              time: attendanceController.checkInTime.value,
              label: 'Check In',
            ),
          ),
          Obx(
            () => ClockIconBox(
              angle: -45,
              time: attendanceController.checkOutTime.value,
              label: 'Check Out',
            ),
          ),
          Obx(
          () => ClockIconBox(
              isDoneIcon: true,
              time: attendanceController.workingHours.value,
              label: 'Work Hrs',
            ),
          ),
        ],
      ),
    );
  }
}

class ClockIconBox extends StatelessWidget {
  const ClockIconBox(
      {super.key,
      this.angle = 0,
      this.isDoneIcon = false,
      this.time,
      required this.label});

  final double angle;
  final bool isDoneIcon;
  final String label;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60.h,
          width: 70.h,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/event10.png',
                    height: 50.h,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 4,
                  child: CircleAvatar(
                    radius: 10.h,
                    backgroundColor: Colors.white,
                    child: Transform.rotate(
                        angle: angle * pi / 180,
                        child: Icon(
                          isDoneIcon
                              ? Icons.done_all_rounded
                              : Icons.double_arrow_rounded,
                          color: primaryColor,
                          size: 20.h,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),

        // TIME
        SizedBox(
          height: 20.h,
          width: 70.h,
          child: Text(
            time ?? '--:--',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.w500),
          ),
        ),

        // LABEL
        SizedBox(
          width: 70.h,
          child: Text(
            label,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.h,
              overflow: TextOverflow.clip,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
