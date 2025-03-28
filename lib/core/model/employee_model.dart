import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String employeeId;
  final String name;
  final String email;
  final String photoUrl;
  final String designation;
  final String department;
  final String teamName;
  final String phone;
  final bool isVerified;
  final Timestamp? createdAt;

  EmployeeModel({
    this.employeeId = "",
    required this.name,
    required this.email,
    this.photoUrl = "",
    this.designation = "",
    this.department = "",
    this.teamName = "",
    this.phone = "",
    this.isVerified = false,
    this.createdAt,
  });

  factory EmployeeModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EmployeeModel(
      employeeId: data['employee_id'] ?? "",
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      photoUrl: data['photo_url'] ?? "",
      designation: data['designation'] ?? "",
      department: data['department'] ?? "",
      teamName: data['team_name'] ?? "",
      phone: data['phone'] ?? "",
      isVerified: data['isVerified'] ?? false,
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'employee_id': employeeId,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'designation': designation,
      'department': department,
      'team_name': teamName,
      'phone': phone,
      'isVerified': isVerified,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
