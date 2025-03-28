import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{


  // Single tone object
  FirebaseServices._();
  static final FirebaseServices fbServices = FirebaseServices._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

}