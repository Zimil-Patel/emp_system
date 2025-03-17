import 'package:emp_system/firebase_options.dart';
import 'package:emp_system/screens/splash%20page/splash_page.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // THIS ENSURES FIREBASE INITIALIZED BEFORE APP RUNS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
