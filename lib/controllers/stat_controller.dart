import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StatsController extends GetxController {
  var employeeId = ''.obs;
  var totalPresents = 0.obs;
  var lateCount = 0.obs;
  var absentCount = 0.obs;
  var earlyLeaveCount = 0.obs;
  var totalDays = 0.obs;

  // To fetch employee stats for a specific employee
  Future<void> fetchStats(String email) async {
    try {
      totalPresents.value = 0;
      lateCount.value = 0;
      absentCount.value = 0;
      earlyLeaveCount.value = 0;
      totalDays.value = 0;

      DocumentSnapshot employeeDoc = await FirebaseFirestore.instance
          .collection('employees')
          .doc(email)
          .get();

      Timestamp joiningTimestamp = employeeDoc['createdAt'];
      DateTime joiningDate = joiningTimestamp.toDate();

      // Get all check-in records from Firestore
      QuerySnapshot checkInSnapshot = await FirebaseFirestore.instance
          .collection('employees')
          .doc(email)
          .collection('checkIns')
          .get();

      Map<String, Map<String, dynamic>> checkInData = {};
      for (var doc in checkInSnapshot.docs) {
        checkInData[doc.id] = doc.data() as Map<String, dynamic>;
      }

      DateTime today = DateTime.now();

      for (DateTime date = joiningDate;
          date.isBefore(today) || date.isAtSameMomentAs(today);
          date = date.add(Duration(days: 1))) {
        String dateKey =
            DateFormat('yyyy-MM-dd').format(date); // Format date as key

        // Skip weekends (Saturday & Sunday)
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          continue;
        }

        totalDays++;

        if (checkInData.containsKey(dateKey)) {
          Map<String, dynamic>? record = checkInData[dateKey];

          if (record == null) continue;

          if (record['checkInTime'] != null) {
            totalPresents.value++;

            if (record['lateReason'] != null) {
              lateCount.value++;
            }
          }

          // Check if employee waa early leaver
          if (record['checkOutTime'] != null) {
            if (record['earlyLeaveReason'] != null) {
              earlyLeaveCount.value++;
            }
          }
        } else {
          log("absent");
          absentCount.value++;
        }
      }

      log("Total Working Days: $totalDays");
      log("Total Presents: ${totalPresents.value}");
      log("Total Lates: ${lateCount.value}");
      log("Total Absents: ${absentCount.value}");
      log("Total Early Leave: ${earlyLeaveCount.value}");
    } catch (e) {
      log("Error fetching stats: $e");
    }
  }
}
