import 'package:emp_system/screens/auth/components/role_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleOptionPage extends StatelessWidget {
  const RoleOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.h,
            child: Container(
              color: Color(0xfff5f9ef),
              child: Image.asset(
                'assets/images/work.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 40.h,),

          // ROLE OPTIONS BUTTONS
          RoleOptions(),

          Spacer(),

          // COMPANY LOGO
          Image.asset('assets/images/logo.png', height: 140.h, width: 140.w,),
        ],
      ),
    );
  }
}
