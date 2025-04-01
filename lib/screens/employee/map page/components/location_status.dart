import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocationStatus extends StatelessWidget {
  const LocationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => attendanceController.isInsideOfficeRange.value
          ? StatusMessageWithIcon(
              icon: 'done_logo',
              status: 'Now you are at office',
            )
          : StatusMessageWithIcon(
              icon: 'alert_logo',
              status: 'You are not in office range',
            ),
    );
  }
}

class StatusMessageWithIcon extends StatelessWidget {
  const StatusMessageWithIcon({
    super.key,
    required this.icon,
    required this.status,
  });

  final String icon, status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/$icon.png',
          height: 18.h,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Status: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.h,
          ),
        ),
        Expanded(
          child: Text(
            status,
            style: TextStyle(
              color: icon == "alert_logo" ? Colors.red.shade400 : Colors.black,
              fontSize: 15.h,
            ),
          ),
        ),
      ],
    );
  }
}
