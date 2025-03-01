import 'dart:developer';

import 'package:emp_system/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  // THIS ENSURES FIREBASE INITIALIZED BEFORE APP RUNS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(EmployeeSystem());
}

// MAIN APPLICATION
class EmployeeSystem extends StatelessWidget {
  const EmployeeSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                 try{
                   final signInAct = await GoogleSignIn().signIn();
                   final googleAuth = await signInAct?.authentication;
                   if(googleAuth != null){
                     final credential = GoogleAuthProvider.credential(
                       accessToken: googleAuth.accessToken,
                       idToken: googleAuth.idToken,
                     );
                     await FirebaseAuth.instance.signInWithCredential(credential);
                   }
                 } catch(e) {
                   log("Exception : $e");
                 }
                },
                child: Text('Sign in with google'),
              ),

              // SIGN OUT
              ElevatedButton(
                onPressed: () async {
                  try{
                    await FirebaseAuth.instance.signOut();
                  } catch(e) {
                    log("Exception : $e");
                  }
                },
                child: Text('Sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
