import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationStatus extends StatelessWidget {
  const LocationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/alert_logo.png',
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
            'You are not in office range',
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: 15.h,
            ),
          ),
        ),
      ],
    );
  }
}
