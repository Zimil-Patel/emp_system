import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_system/core/model/employee_model.dart';

class FirebaseServices {
  // Single tone object
  FirebaseServices._();

  static final FirebaseServices fbServices = FirebaseServices._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current employee profile details
  Future<EmployeeModel> getCurrentEmployeeProfileDetails(String email) async {
    final snapshot = await _firestore.collection('employees').doc(email).get();
    return EmployeeModel.fromFirestore(snapshot);
  }

  // Update current employee profile details
  Future<bool> updateEmployeeProfileDetails({required String email, required String name, required String designation, required String department, required String teamName, required String phone,}) async {
    try {
      await _firestore.collection('employees').doc(email).update({
        'name': name,
        'designation': designation,
        'department': department,
        'team_name': teamName,
        'phone': phone,
      });
      return true;
    } catch (e) {
      log("ERROR: updating profile -> $e");
      return false;
    }
  }


  // Update employee profile photo
  Future<bool> updateEmployeeProfilePhoto(String url, String email) async {
    try{
      await _firestore.collection('employees').doc(email).update({
        'photo_url': url,
      });
      return true;
    } catch(e){
      log("ERROR: profile update");
      return false;
    }
  }
}
