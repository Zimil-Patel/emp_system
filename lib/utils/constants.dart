import 'package:emp_system/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/supervisor_controller.dart';

final AuthController authController = Get.put(AuthController());
final SupervisorController supervisorController = Get.put(SupervisorController());
const String supervisorEmail = "admin@gmail.com";
const String supervisorPassword = "admin";

