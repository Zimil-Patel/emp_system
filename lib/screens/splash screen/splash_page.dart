import 'dart:async';
import 'dart:developer';
import 'package:emp_system/screens/auth/role_option_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgressAnimation();
  }

  void _startProgressAnimation() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_progress >= 1.0) {
        timer.cancel();
        log("Progress Completed!");
        Get.offAll(() => RoleOptionPage());
      } else {
        setState(() {
          _progress += 0.05;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // COMPANY LOGO
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 240.w,
              height: 240.h,
            ),
          ),

          // BOTTOM PROGRESS LOADING BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.h, left: 50.w, right: 50.w),
              child: LinearProgressIndicator(
                value: _progress,
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
