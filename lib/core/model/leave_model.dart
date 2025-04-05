import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  final String id;
  final String email;
  final String employeeId;
  final String employeeName;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;
  final String status;
  final String? remarks;

  LeaveModel({
    required this.id,
    required this.email,
    required this.employeeId,
    required this.employeeName,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
    this.remarks,
  });

  factory LeaveModel.fromMap(Map<String, dynamic> data, String id) {
    return LeaveModel(
      id: id,
      email: data['email'],
      employeeId: data['employeeId'],
      employeeName: data['employeeName'],
      leaveType: data['leaveType'],
      fromDate: (data['fromDate'] as Timestamp).toDate(),
      toDate: (data['toDate'] as Timestamp).toDate(),
      reason: data['reason'],
      status: data['status'],
      remarks: data['remarks'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'leaveType': leaveType,
      'fromDate': fromDate,
      'toDate': toDate,
      'reason': reason,
      'status': status,
      'remarks': remarks,
    };
  }
}
