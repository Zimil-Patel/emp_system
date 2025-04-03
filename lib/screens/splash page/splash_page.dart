import 'dart:async';
import 'dart:developer';
import 'package:emp_system/screens/auth/role_option_page.dart';
import 'package:emp_system/screens/employee/home%20page/home_page.dart';
import 'package:emp_system/screens/supervisor/home%20page/supervisor_home_page.dart';
import 'package:emp_system/utils/constants.dart';
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
  String? _role;

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
        _navigateToNext();
      } else {
        setState(() {
          _progress += 0.05;
        });
      }
    });
  }


  // Ensure role is assigned then navigate to next page
  Future<void> _navigateToNext() async {
    if(_role == null){
      await _checkUserRole();
    }

    if(_role == "supervisor"){
      supervisorController.fetchEmployeeList();
      Get.offAll(() => SupervisorHomePage());
    } else if (_role == "employee"){
      await authController.getCurrentUser();
      profileController.setUpFields();
      await attendanceController.checkTodayAttendance();
      log("Employee Name : ${profileController.txtName.text}");
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => RoleOptionPage());
    }
  }

  Future<void> _checkUserRole() async {
    _role = await authController.checkUserRole() ?? "not found";
    _role = _role!.toLowerCase();
    log("Role: $_role");
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
