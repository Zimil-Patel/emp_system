import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../core/services/attendance_services.dart';

class AttendanceController extends GetxController {
  final AttendanceService _attendanceService = AttendanceService();
  RxBool isCheckingIn = false.obs;
  RxBool isCheckingOut = false.obs;
  RxString selectedReason = "".obs;
  var txtReason = TextEditingController();

  // CHECK-IN PROCESS
  Future<void> checkInEmployee(String email) async {
    try {
      isCheckingIn.value = true;

      Position position = await Geolocator.getCurrentPosition();
      bool isInside = await _attendanceService.isWithinOfficeRange(position);

      if (!isInside) {
        Get.snackbar("Location Error", "You are outside the office range.");
        Get.toNamed("/mapPage");
        return;
      }

      DateTime now = DateTime.now();
      bool isLate = now.isAfter(_attendanceService.officeStartTime);

      if (isLate) {
        Get.defaultDialog(
            title: "Late Check-in",
            content: Column(
              children: [
                Text("Select a reason for being late:"),
                Obx(() => Column(
                  children: ["Traffic", "Forgot", "Other"].map((reason) {
                    return RadioListTile(
                      title: Text(reason),
                      value: reason,
                      groupValue: selectedReason.value,
                      onChanged: (value) {
                        selectedReason.value = value!;
                      },
                    );
                  }).toList(),
                )),
                Obx(() => selectedReason.value == "Other"
                    ? TextField(controller: txtReason)
                    : Container()
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _attendanceService.checkIn(email,
                        selectedReason.value == "Other" ? txtReason.text : selectedReason.value);
                    Get.back();
                    Get.snackbar("Success", "Check-in successful!");
                  },
                  child: Text("Submit"),
                )
              ],
            )
        );
      } else {
        await _attendanceService.checkIn(email, null);
        Get.snackbar("Success", "Check-in successful!");
      }

      updateHomeButtonState();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isCheckingIn.value = false;
    }
  }

  // CHECK-OUT PROCESS
  Future<void> checkOutEmployee(String email) async {
    try {
      isCheckingOut.value = true;
      await _attendanceService.checkOut(email);
      Get.snackbar("Success", "Check-out successful!");
      updateHomeButtonState();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isCheckingOut.value = false;
    }
  }

  void updateHomeButtonState() {
    // Logic to dynamically update HomePage button
  }
}
