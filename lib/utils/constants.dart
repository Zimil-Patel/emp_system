import 'package:emp_system/controllers/attendance_controller.dart';
import 'package:emp_system/controllers/auth_controller.dart';

import '../controllers/profile_controller.dart';
import '../controllers/supervisor_controller.dart';

late AuthController authController;
late SupervisorController supervisorController;
late ProfileController profileController;
late AttendanceController attendanceController;

const String supervisorEmail = "admin@gmail.com";
const String supervisorPassword = "admin";
