import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_system/core/model/employee_model.dart';

class FirebaseServices{

  // Single tone object
  FirebaseServices._();
  static final FirebaseServices fbServices = FirebaseServices._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current employee profile details
  Future<EmployeeModel> getCurrentEmployeeProfileDetails(String email) async {
     final snapshot = await _firestore.collection('employees').doc(email).get();
     return EmployeeModel.fromFirestore(snapshot);
  }
}