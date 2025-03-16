
import 'package:emp_system/firebase_options.dart';
import 'package:emp_system/screens/auth/supervisor_sign_in_page.dart';
import 'package:emp_system/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  // THIS ENSURES FIREBASE INITIALIZED BEFORE APP RUNS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      builder: (context, child) => MaterialApp(
        theme: AppTheme.lightTheme,
        home: SupervisorSignInPage(),
      ),
    );
  }
}
