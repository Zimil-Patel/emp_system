import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPercentageIndicator(String percentage, String label) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade200,
              value: double.parse(percentage) / 100,
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(
                getPercentageColor(
                  double.parse(percentage),
                ),
              ),
            ),
          ),
          Text(
            "$percentage%",
            style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: 5),
      Text(
        label,
        style: TextStyle(fontSize: 14.h),
      ),
    ],
  );
}

Color getPercentageColor(double percentage) {
  if (percentage < 30) {
    return Colors.green.shade400;
  } else if (percentage >= 30 && percentage < 60) {
    return Colors.orange.shade400;
  } else {
    return Colors.red.shade400;
  }
}
