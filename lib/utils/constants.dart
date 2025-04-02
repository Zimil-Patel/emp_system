import 'package:emp_system/controllers/attendance_controller.dart';
import 'package:emp_system/controllers/auth_controller.dart';
import 'package:emp_system/controllers/stat_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/profile_controller.dart';
import '../controllers/supervisor_controller.dart';

late AuthController authController;
late SupervisorController supervisorController;
late ProfileController profileController;
late AttendanceController attendanceController;
late StatsController statsController;

const String supervisorEmail = "admin@gmail.com";
const String supervisorPassword = "admin";


// SACHIN
// final LatLng officeLocation = LatLng(21.084967, 72.881111);

// BMU
// final LatLng officeLocation = LatLng(21.139171, 72.793428);

// RNW
final LatLng officeLocation = LatLng(21.142412, 72.881517);