import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // OFFICE LOCATION
  final double officeLatitude = officeLocation.latitude;
  final double officeLongitude = officeLocation.longitude;
  final double officeRange = 200; // 100 meters

  Future<bool> isWithinOfficeRange(Position position) async {
    double distance = Geolocator.distanceBetween(
        officeLatitude, officeLongitude, position.latitude, position.longitude);
    return distance <= officeRange;
  }

  // calculate office timings for today
  DateTime get officeStartTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 9, 15, 0);
  }

  DateTime get officeEndTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 17, 30, 0);
  }

  // CHECK TODAY'S ATTENDANCE STATUS
  Future<Map<String, dynamic>> getTodayAttendance(String email) async {
    String today = DateTime.now().toIso8601String().substring(0, 10);

    try {
      log("Called get Today Attendance");
      DocumentSnapshot snapshot = await _firestore
          .collection('employees')
          .doc(email)
          .collection('checkIns')
          .doc(today)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        DateTime? checkInTime = data.containsKey('checkInTime')
            ? (data['checkInTime'] as Timestamp).toDate()
            : null;
        DateTime? checkOutTime = data.containsKey('checkOutTime')
            ? (data['checkOutTime'] as Timestamp).toDate()
            : null;

        return {
          "checkedIn": data.containsKey('checkInTime'),
          "checkedOut": data.containsKey('checkOutTime'),
          "checkInTime": checkInTime,
          "checkOutTime": checkOutTime,
        };
      } else {
        return {"checkedIn": false, "checkedOut": false};
      }
    } catch (e) {
      log("ERROR: in today attendance");
      return {"checkedIn": false, "checkedOut": false};
    }
  }

  // CHECK-IN FUNCTION
  Future<void> checkIn(String email, String? reason) async {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    DateTime checkInTime = DateTime.now();
    bool isLate = checkInTime.isAfter(officeStartTime);

    // Store check-in time as a Timestamp
    await _firestore
        .collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .set({
      'checkInTime': Timestamp.fromDate(checkInTime), // Store as Timestamp
      'lateReason': isLate ? reason : null,
      'status': 'Present',
    }, SetOptions(merge: true));
  }

  // CHECK-OUT FUNCTION
  Future<void> checkOut(String email, String? reason) async {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    DateTime checkOutTime = DateTime.now();

    DocumentSnapshot snapshot = await _firestore
        .collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .get();

    if (!snapshot.exists) return;

    // Store check-out time as a Timestamp
    await _firestore
        .collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .set({
      'checkOutTime': Timestamp.fromDate(checkOutTime),
      'earlyLeaveReason': reason,
    }, SetOptions(merge: true));
  }

}
