import 'dart:developer';

import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../core/services/attendance_services.dart';
import '../screens/employee/map page/map_page.dart';
import 'auth_controller.dart';

class AttendanceController extends GetxController {
  final AttendanceService _attendanceService = AttendanceService();
  final AuthController _authController = Get.find<AuthController>();

  RxBool hasCheckedIn = false.obs;
  RxBool hasCheckedOut = false.obs;
  RxString selectedReason = "".obs;

  RxString checkInTime = "--:--".obs;
  RxString checkOutTime = "--:--".obs;
  RxString workingHours = "--:--".obs;

  RxBool isInsideOfficeRange = false.obs;

  var txtReason = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkTodayAttendance();
  }

  // CHECK TODAY'S ATTENDANCE STATUS
  Future<void> checkTodayAttendance() async {
    try {
      log("Called check attendance");
      var todayStatus = await _attendanceService
          .getTodayAttendance(_authController.currentEmployee!.email);
      hasCheckedIn.value = todayStatus['checkedIn'] ?? false;
      hasCheckedOut.value = todayStatus['checkedOut'] ?? false;

      checkInTime.value = convertTo12HourFormat(todayStatus['checkInTime']);
      checkOutTime.value = convertTo12HourFormat(todayStatus['checkOutTime']);

      if (checkInTime.value.isNotEmpty && checkOutTime.value.isNotEmpty) {
        await calculateWorkingHours();
      } else {
        workingHours.value = "--:--";
      }
    } catch (e) {
      log("Some Exception: In formation");
    }
  }

  // CHECK-IN PROCESS
  Future<void> checkInEmployee(String email) async {
    // IF ALREADY DONE CANCEL IT
    if (hasCheckedIn.value) {
      log("Called");
      Get.snackbar("Check-in Error", "You have already checked in today.");
      return;
    }

    // IF NOT THEN CONTINUE
    try {
      DateTime now = DateTime.now();
      bool isLate = now.isAfter(_attendanceService.officeStartTime);
      String formattedCheckInTime = DateFormat('h:mm a').format(now);

      if (isLate) {
        showLateAlert(formattedCheckInTime);
      } else {
        await _attendanceService.checkIn(email, null);
        hasCheckedIn.value = true;
        checkInTime.value = formattedCheckInTime;
        showCheckInSnackBar();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // CHECK-OUT PROCESS
  Future<void> checkOutEmployee(String email) async {
    // IN CASE WHEN USER CLICK ON CHECKOUT BEFORE CHECKING IN
    if (!hasCheckedIn.value) {
      Get.snackbar("Check-out Error", "You need to check in first.");
      return;
    }

    // IF ALREADY CHECKED OUT FOR TOADY
    if (hasCheckedOut.value) {
      Get.snackbar(
        "Done",
        "You have already checked out today.",
        backgroundColor: Colors.orange.shade800,
        colorText: Colors.white,
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
          size: 28,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 3),
        shouldIconPulse:
            false, // Disable icon pulse animation for a more subtle effect
      );
      return;
    }

    // IF NOT THEN CONTINUE
    try {
      DateTime now = DateTime.now();
      String formattedCheckOutTime = DateFormat('h:mm a').format(now);

      bool isBefore = now.isBefore(_attendanceService.officeEndTime);

      if (isBefore) {
        showEarlyLeaveAlert( formattedCheckOutTime);
      } else {
        await _attendanceService.checkOut(email, null);
        hasCheckedOut.value = true;
        checkOutTime.value = formattedCheckOutTime;
        await calculateWorkingHours();
        showCheckOutSnackBar();
      }
    } catch (e) {
      log("Exception: In formation");
    }
  }

  // CALCULATE WORKING HOURS
  Future<void> calculateWorkingHours() async {
    log("Called");
    if (checkInTime.value == "--:--" || checkOutTime.value == "--:--") return;

    final todayStatus = await _attendanceService
        .getTodayAttendance(_authController.currentEmployee!.email);

    final inTime = todayStatus['checkInTime'];
    final outTime = todayStatus['checkOutTime'];

    if (inTime == null || outTime == null) return;

    Duration difference = outTime.difference(inTime);

    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;

    workingHours.value = "${hours}h:${minutes}m";
  }

  // Convert DateTime to 12-hour format
  String convertTo12HourFormat(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    try {
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return '--:--';
    }
  }
}

showCheckOutSnackBar() {
  Get.snackbar(
    "Success",
    "Check-out successful!",
    backgroundColor: Colors.green.shade800,
    colorText: Colors.white,
    icon: Icon(
      Icons.check_circle_outline,
      color: Colors.white,
      size: 28,
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(12),
    borderRadius: 8,
    duration: Duration(seconds: 3),
    shouldIconPulse:
        false, // Disable icon pulse animation for a more subtle effect
  );
}

showCheckInSnackBar() {
  Get.snackbar(
    "Success",
    "Check-in successful!",
    backgroundColor: Colors.blue.shade800,
    colorText: Colors.white,
    icon: Icon(
      Icons.check_circle_outline,
      color: Colors.white,
      size: 28,
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(12),
    borderRadius: 8,
    duration: Duration(seconds: 3),
    shouldIconPulse:
        false, // Disable icon pulse animation for a more subtle effect
  );
}

showLateAlert( String formattedCheckInTime) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.h),
      ),
      title: Row(
        children: [
          Text('You are late'),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.red.shade400,
                ),
              ),
              child: Icon(
                Icons.close,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // MAIL ICON
          Image.asset(
            'assets/images/alert_logo.png',
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(height: 5.h),

          // DIALOG MESSAGE
          Text("Select a reason for being late:"),
          Obx(() => Column(
                children: ["Traffic", "Forgot", "Other"].map((reason) {
                  return RadioListTile(
                    title: Text(reason),
                    value: reason,
                    groupValue: attendanceController.selectedReason.value,
                    onChanged: (value) =>
                        attendanceController.selectedReason.value = value!,
                    activeColor: Colors.green,
                  );
                }).toList(),
              )),
          Obx(() => attendanceController.selectedReason.value == "Other"
              ? TextField(
                  controller: attendanceController.txtReason,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Enter reason',
                    fillColor: Colors.grey.withOpacity(
                      0.4,
                    ),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                )
              : Container()),

          SizedBox(height: 10.h),

          // SUBMIT BUTTON
          ElevatedButton(
            onPressed: () async {
              // Replace with actual functionality if needed
              await attendanceController._attendanceService.checkIn(
                  authController.currentEmployee!.email,
                  attendanceController.selectedReason.value == "Other"
                      ? attendanceController.txtReason.text.isEmpty
                          ? "Not mentioned"
                          : attendanceController.txtReason.text
                      : attendanceController.selectedReason.value);
              attendanceController.hasCheckedIn.value = true;
              attendanceController.checkInTime.value = formattedCheckInTime;
              Get.back();
              showCheckInSnackBar();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: Text("Submit", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}

showEarlyLeaveAlert(String formattedCheckOutTime) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.h),
      ),
      title: Row(
        children: [
          Text('Early Leave'),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.red.shade400,
                ),
              ),
              child: Icon(
                Icons.close,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ICON
          Image.asset(
            'assets/images/alert_logo.png',
            // Use a relevant icon for early leave
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(height: 5.h),

          // DIALOG MESSAGE
          Text("Select a reason for early leave:"),
          Obx(() => Column(
                children: ["Personal", "Health", "Other"].map((reason) {
                  return RadioListTile(
                    title: Text(reason),
                    value: reason,
                    groupValue: attendanceController.selectedReason.value,
                    onChanged: (value) =>
                        attendanceController.selectedReason.value = value!,
                    activeColor: Colors.green,
                  );
                }).toList(),
              )),
          Obx(() => attendanceController.selectedReason.value == "Other"
              ? TextField(
                  controller: attendanceController.txtReason,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Enter reason',
                    fillColor: Colors.grey.withOpacity(
                      0.4,
                    ),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                )
              : Container()),

          SizedBox(height: 10.h),

          // SUBMIT BUTTON
          ElevatedButton(
            onPressed: () async {
              // Replace with actual functionality if needed
              await attendanceController._attendanceService.checkOut(
                  authController.currentEmployee!.email,
                  attendanceController.selectedReason.value == "Other"
                      ? attendanceController.txtReason.text.isEmpty
                          ? "Not mentioned"
                          : attendanceController.txtReason.text
                      : attendanceController.selectedReason.value);
              attendanceController.hasCheckedOut.value = true;
              attendanceController.checkOutTime.value = formattedCheckOutTime;
              await attendanceController.calculateWorkingHours();
              Get.back();
              showCheckOutSnackBar();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: Text("Submit", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
