import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreetProfileMessage extends StatelessWidget {
  const GreetProfileMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey! Brian', style: TextStyle(fontSize: 24.h),),
              Text('Good morning! Mark your attendance', style: TextStyle(fontSize: 14.h, color: Colors.black54),),
            ],
          ),
        ),
        CircleAvatar(
          radius: 20.h,
          backgroundColor: Colors.grey.shade400,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
      ],
    );
  }
}
