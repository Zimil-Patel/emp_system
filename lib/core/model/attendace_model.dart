import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceData {
  final String name;
  final String id;
  final String? checkInTime;
  final String? checkOutTime;
  final bool isLate;
  final bool isEarly; // New field added

  AttendanceData(this.name, this.id, this.checkInTime, this.checkOutTime, this.isLate, this.isEarly);

  // Convert Firestore document to AttendanceData
  factory AttendanceData.fromFirestore(Map<String, dynamic> data, String name, String id) {
    return AttendanceData(
      name,
      id,
      data['checkInTime'] != null ? DateFormat('h:mm').format((data['checkInTime'] as Timestamp).toDate()) : "--:--",
      data['checkOutTime'] != null ? DateFormat('h:mm').format((data['checkOutTime'] as Timestamp).toDate()) : "--:--",
      data['lateReason'] != null,
      data['earlyLeaveReason'] != null,
    );
  }
}
