
import 'dart:math';

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
import 'package:cloud_firestore/cloud_firestore.dart';

import 'controllers/auth_controller.dart';
import 'controllers/stat_controller.dart';
import 'controllers/supervisor_controller.dart';

Future<void> main() async {
  // THIS ENSURES FIREBASE INITIALIZED BEFORE APP RUNS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _initControllers();
  await insertDummyRecord();

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

Future<void> insertDummyRecord() async {
  final dummyData = generateDummyEmployeeAttendance(
    createdAt: DateTime(2025, 3, 1),
    endDate: DateTime(2025, 4, 11),
  );

  await uploadDummyAttendanceToFirestore(dummyData);
}


List<Map<String, dynamic>> generateDummyEmployeeAttendance({
  required DateTime createdAt,
  required DateTime endDate,
}) {
  final List<Map<String, dynamic>> dummyRecords = [];
  final random = Random();

  final String email = "jash24@gmail.com";
  final String name = "Jay Katariya";
  final String employeeId = "EMP0001";

  final lateReasons = ["Traffic", "Health issue", "Forgot"];
  final earlyReasons = ["Family emergency", "Doctor appointment", "Felt unwell"];

  DateTime current = createdAt;

  while (current.isBefore(endDate.add(const Duration(days: 1)))) {
    // Generate random check-in between 8:45 AM and 9:45 AM
    final checkInHour = 8 + random.nextInt(2); // 8 or 9
    final checkInMinute = random.nextInt(60);
    final checkIn = DateTime(current.year, current.month, current.day, checkInHour, checkInMinute);

    // Generate random check-out between 5:00 PM and 6:30 PM
    final checkOutHour = 17 + random.nextInt(2); // 17 or 18
    final checkOutMinute = random.nextInt(60);
    final checkOut = DateTime(current.year, current.month, current.day, checkOutHour, checkOutMinute);

    // Check for late/early conditions
    bool isLate = checkIn.isAfter(DateTime(current.year, current.month, current.day, 9, 15));
    bool isEarly = checkOut.isBefore(DateTime(current.year, current.month, current.day, 17, 30));

    dummyRecords.add({
      "date": "${current.year.toString().padLeft(4, '0')}-${current.month.toString().padLeft(2, '0')}-${current.day.toString().padLeft(2, '0')}",
      "checkIn": checkIn.toIso8601String(),
      "checkOut": checkOut.toIso8601String(),
      "name": name,
      "email": email,
      "employeeId": employeeId,
      "status": "Present",
      "lateReason": isLate ? lateReasons[random.nextInt(lateReasons.length)] : null,
      "earlyLeaveReason": isEarly ? earlyReasons[random.nextInt(earlyReasons.length)] : null,
    });

    current = current.add(const Duration(days: 1));
  }

  return dummyRecords;
}



Future<void> uploadDummyAttendanceToFirestore(List<Map<String, dynamic>> records) async {
  final firestore = FirebaseFirestore.instance;
  final email = records[0]['email'];
  final employeeDocRef = firestore.collection('employees').doc(email);

  // 1. Set base employee data (merge: true in case already exists)
  await employeeDocRef.set({
    "createdAt": Timestamp.fromDate(DateTime(2025, 3, 1)),
    "department": "Testing",
    "designation": "Software Tester",
    "email": email,
    "employee_id": records[0]['employeeId'],
    "isVerified": true,
    "name": records[0]['name'],
    "phone": "7456826594",
    "photo_url": null,
    "team_name": "Top Tester",
  }, SetOptions(merge: true));

  for (var record in records) {
    final checkInId = record['date']; // yyyy-MM-dd

    // 2. Add checkIn record
    await employeeDocRef
        .collection("checkIns")
        .doc(checkInId)
        .set({
      "checkInTime": Timestamp.fromDate(DateTime.parse(record['checkIn'])),
      "checkOutTime": Timestamp.fromDate(DateTime.parse(record['checkOut'])),
      "earlyLeaveReason": record['earlyLeaveReason'],
      "lateReason": record['lateReason'],
      "status": "Present",
    }, SetOptions(merge: true));
  }

  print("✅ Dummy attendance uploaded to Firestore!");
}
