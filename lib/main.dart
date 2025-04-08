import 'package:emp_system/controllers/attendance_controller.dart';
import 'package:emp_system/controllers/leave_controller.dart';
import 'package:emp_system/controllers/profile_controller.dart';
import 'package:emp_system/controllers/report_controller.dart';
import 'package:emp_system/firebase_options.dart';
import 'package:emp_system/screens/splash%20page/splash_page.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/stat_controller.dart';
import 'controllers/supervisor_controller.dart';

Future<void> main() async {
  // THIS ENSURES FIREBASE INITIALIZED BEFORE APP RUNS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _initControllers();
  runApp(EmployeeSystem());
}

// MAIN APPLICATION
class EmployeeSystem extends StatelessWidget {
  const EmployeeSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690), // Base reference size
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: SplashPage(),
      ),
    );
  }
}

void _initControllers() {
  authController = Get.put(AuthController());
  profileController = Get.put(ProfileController());
  supervisorController = Get.put(SupervisorController());
  attendanceController = Get.put(AttendanceController());
  statsController = Get.put(StatsController());
  reportController = Get.put(ReportController());
  leaveController = Get.put(LeaveController());
}
