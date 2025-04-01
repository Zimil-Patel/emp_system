import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // OFFICE LOCATION
  final double officeLatitude = 21.084967;
  final double officeLongitude = 72.881111;
  final double officeRange = 200; // 100 meters

  Future<bool> isWithinOfficeRange(Position position) async {
    double distance = Geolocator.distanceBetween(
        officeLatitude, officeLongitude, position.latitude, position.longitude);
    return distance <= officeRange;
  }

  // calculate office timings for today
  DateTime get officeStartTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 9, 0, 0); // 9:00 AM
  }

  DateTime get officeEndTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 18, 0, 0); // 6:00 PM
  }


  // CHECK-IN FUNCTION
  Future<void> checkIn(String email, String? reason) async {

    String today = DateTime.now().toIso8601String().substring(0, 10);
    DateTime checkInTime = DateTime.now();
    bool isLate = checkInTime.isAfter(officeStartTime);

    await _firestore.collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .set({
      'checkInTime': checkInTime.toIso8601String(),
      'lateReason': isLate ? reason : null,
      'status': 'Present',
    }, SetOptions(merge: true));
  }

  // CHECK-OUT FUNCTION
  Future<void> checkOut(String email) async {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    DateTime checkOutTime = DateTime.now();

    DocumentSnapshot snapshot = await _firestore.collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .get();

    if (!snapshot.exists) throw "Check-in not found!";

    await _firestore.collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .set({
      'checkOutTime': checkOutTime.toIso8601String(),
    }, SetOptions(merge: true));
  }

  // MARK ABSENT IF NO CHECK-IN
  Future<void> markAbsentIfNoCheckIn(String email) async {
    String yesterday = DateTime.now().subtract(Duration(days: 1)).toIso8601String().substring(0, 10);
    DocumentSnapshot snapshot = await _firestore.collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(yesterday)
        .get();

    if (!snapshot.exists) {
      await _firestore.collection('employees')
          .doc(email)
          .collection('checkIns')
          .doc(yesterday)
          .set({'status': 'Absent'}, SetOptions(merge: true));
    }
  }

  // MARK MISSING CHECKOUT
  Future<void> markMissingCheckOut(String email) async {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    DocumentSnapshot snapshot = await _firestore.collection('employees')
        .doc(email)
        .collection('checkIns')
        .doc(today)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('checkInTime') && !data.containsKey('checkOutTime')) {
        await _firestore.collection('employees')
            .doc(email)
            .collection('checkIns')
            .doc(today)
            .set({'status': 'Missing Checkout'}, SetOptions(merge: true));
      }
    }
  }
}
