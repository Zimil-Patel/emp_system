import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupervisorLoginPage extends StatelessWidget {
  const SupervisorLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WELCOME TAGLINES
            Text(
              'Welcome Back! \n"Your Workforce, Your Control"',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.h),
            ),

            // WORK TIME LOGO
            AspectRatio(
              aspectRatio: 1.h,
              child: Image.asset('assets/images/timeWork.png'),
            ),
          ],
        ),
      ),
    );
  }
}
