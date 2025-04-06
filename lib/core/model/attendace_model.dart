import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceData {
  final String name;
  final String id;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final bool isLate;
  final bool isEarly;
  final String? department;

  AttendanceData(this.name, this.id, this.checkInTime, this.checkOutTime,
      this.isLate, this.isEarly, this.department);

  factory AttendanceData.fromFirestore(
      Map<String, dynamic> data, String name, String id, String? department) {
    return AttendanceData(
      name,
      id,
      data['checkInTime'] != null
          ? (data['checkInTime'] as Timestamp).toDate()
          : null,
      data['checkOutTime'] != null
          ? (data['checkOutTime'] as Timestamp).toDate()
          : null,
      data['lateReason'] != null,
      data['earlyLeaveReason'] != null,
      department,
    );
  }

  toMap() {
    return {
      'ID': id,
      'Employee': name,
      'Check-in Time' : checkInTime != null ? DateFormat("h:mm a").format(checkInTime!) : "--:--",
      'Check-out Time' : checkOutTime != null ? DateFormat("h:mm a").format(checkOutTime!) : "--:--",
    };
  }
}
