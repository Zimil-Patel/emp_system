import 'dart:math' as math;
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // Single tone object
  AuthServices._();

  static final AuthServices authServices = AuthServices._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Generate Employee id
  Future<String> generateUniqueEmployeeId() async {
    String employeeId;
    bool exists = false;

    do {
      final random = math.Random();
      int number = random.nextInt(9000) + 1000;
      employeeId = "EMP$number";

      // Check if this employee id already exists
      QuerySnapshot snapshot = await _firestore
          .collection("employees")
          .where('employeeId', isEqualTo: employeeId)
          .get();

      exists = snapshot.docs.isNotEmpty;
    } while (exists);

    return employeeId;
  }

  // Check if new user or not
  Future<bool> isNewUser(String email) async {
    final snapshot = await _firestore.collection('employees').doc(email).get();
    return !snapshot.exists;
  }

  // Add Employee to Firebase
  Future<String> addEmployeeToDatabase(String email, String name) async {
    try {
      await _firestore.collection('employees').doc(email).set({
        'employee_id': "",
        'name': name,
        'email': email,
        'photo_url': '',
        'designation': '',
        'department': '',
        'team_name': '',
        'phone': '',
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return "success";
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // Approve Employee
  Future<bool> approveEmployee({required String email, required bool value, required String employeeId}) async {
    try {
      if (employeeId.isEmpty) {
        employeeId = await generateUniqueEmployeeId();
      }
      await _firestore.collection('employees').doc(email).update({
        'isVerified': value,
        'employee_id': employeeId,
      });

      return true;
    } catch (e) {
      log("Error$e");
      return false;
    }
  }

  // Register Employee
  Future<(User?, String)> signUpEmployeeWithEmailPassword(String email, String password) async {
    try {
      UserCredential? userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return (userCredential.user, "success");
    } catch (e) {
      log("Error: $e");
      return (null, e.toString());
    }
  }

  // Sign in Employee with email and password
  Future<(User?, String)> signInEmployeeWithEmailPassword({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return (userCredential.user!, "");
    } catch (e) {
      log("Error: $e");
      return (null, e.toString());
    }
  }

  // Sign in with google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUsers = await _googleSignIn.signIn();
      if (googleUsers == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUsers.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);
      return userCredential.user;
    } catch (e) {
      log("Google Sign in error: $e");
      return null;
    }
  }

  // Check if user is verified
  Future<bool> checkIsEmployeeVerified(String email) async {
    try {
      final snapshot =
          await _firestore.collection('employees').doc(email).get();
      return snapshot.exists ? snapshot['isVerified'] ?? false : false;
    } catch (e) {
      log("Error Checking : $e");
      return false;
    }
  }

  // Sign out employee
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  // Get current user
  String? getCurrentEmployeeEmail(){
    return _firebaseAuth.currentUser!.email;
  }
}
