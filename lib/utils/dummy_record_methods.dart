import 'package:firebase_auth/firebase_auth.dart';

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';


final List<Map<String, dynamic>> dummyEmployeesEmails = [
  {
    "email": "alicefernandez001@gmail.com",
    "name": "Alice Fernandez",
    "employee_id": "EMP0001",
  },
  {
    "email": "brianthomas002@gmail.com",
    "name": "Brian Thomas",
    "employee_id": "EMP0002",
  },
  {
    "email": "chloerivera003@gmail.com",
    "name": "Chloe Rivera",
    "employee_id": "EMP0003",
  },
  {
    "email": "davidlopez004@gmail.com",
    "name": "David Lopez",
    "employee_id": "EMP0004",
  },
  {
    "email": "elizabethkim005@gmail.com",
    "name": "Elizabeth Kim",
    "employee_id": "EMP0005",
  },
  {
    "email": "fionatan006@gmail.com",
    "name": "Fiona Tan",
    "employee_id": "EMP0006",
  },
  {
    "email": "georgeray007@gmail.com",
    "name": "George Ray",
    "employee_id": "EMP0007",
  },
  {
    "email": "hannahlin008@gmail.com",
    "name": "Hannah Lin",
    "employee_id": "EMP0008",
  },
  {
    "email": "isaaczhang009@gmail.com",
    "name": "Isaac Zhang",
    "employee_id": "EMP0009",
  },
  {
    "email": "juliaramos010@gmail.com",
    "name": "Julia Ramos",
    "employee_id": "EMP0010",
  },
];

Future<void> createDummyAccounts() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  for (var employee in dummyEmployeesEmails) {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: employee['email'],
        password: '123456789',
      );
      print('✅ Created: ${employee['email']}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('⚠️ Already exists: ${employee['email']}');
      } else {
        print('❌ Error creating ${employee['email']}: ${e.message}');
      }
    } catch (e) {
      print('🔥 Unexpected error for ${employee['email']}: $e');
    }
  }
}

Future<void> insertDummyRecord() async {
  for (int i = 0; i < dummyEmployees.length; i++) {
    // final dummyData = generateDummyEmployeeAttendance(
    //     createdAt: dummyEmployees[i]['createdAt'],
    //     endDate: dummyEmployees[i]['endDate'],
    //     index: i);

    await uploadDummyAttendanceToFirestore([], i);
  }
}

List<Map<String, dynamic>> generateDummyEmployeeAttendance({required DateTime createdAt, required DateTime endDate, required int index}) {
  final List<Map<String, dynamic>> dummyRecords = [];
  final random = Random();

  final String email = dummyEmployees[index]['email'];
  final String name = dummyEmployees[index]['name'];
  final String employeeId = dummyEmployees[index]['employee_id'];

  final lateReasons = ["Traffic", "Health issue", "Forgot"];
  final earlyReasons = [
    "Family emergency",
    "Doctor appointment",
    "Felt unwell"
  ];

  DateTime current = createdAt;

  while (current.isBefore(endDate.add(const Duration(days: 1)))) {
    // Generate random check-in between 8:45 AM and 9:45 AM
    final checkInHour = 8 + random.nextInt(2); // 8 or 9
    final checkInMinute = random.nextInt(60);
    final checkIn = DateTime(
        current.year, current.month, current.day, checkInHour, checkInMinute);

    // Generate random check-out between 5:00 PM and 6:30 PM
    final checkOutHour = 17 + random.nextInt(2); // 17 or 18
    final checkOutMinute = random.nextInt(60);
    final checkOut = DateTime(
        current.year, current.month, current.day, checkOutHour, checkOutMinute);

    // Check for late/early conditions
    bool isLate = checkIn
        .isAfter(DateTime(current.year, current.month, current.day, 9, 15));
    bool isEarly = checkOut
        .isBefore(DateTime(current.year, current.month, current.day, 17, 30));

    dummyRecords.add({
      "date":
          "${current.year.toString().padLeft(4, '0')}-${current.month.toString().padLeft(2, '0')}-${current.day.toString().padLeft(2, '0')}",
      "checkIn": checkIn.toIso8601String(),
      "checkOut": checkOut.toIso8601String(),
      "name": name,
      "email": email,
      "employeeId": employeeId,
      "status": "Present",
      "lateReason":
          isLate ? lateReasons[random.nextInt(lateReasons.length)] : null,
      "earlyLeaveReason":
          isEarly ? earlyReasons[random.nextInt(earlyReasons.length)] : null,
    });

    current = current.add(const Duration(days: 1));
  }

  return dummyRecords;
}

Future<void> uploadDummyAttendanceToFirestore(
    List<Map<String, dynamic>> records, int index) async {
  final firestore = FirebaseFirestore.instance;
  final email = dummyEmployees[index]['email'];
  final employeeDocRef = firestore.collection('employees').doc(email);

  // 1. Set base employee data (merge: true in case already exists)
  await employeeDocRef.update({
    "employee_id": dummyEmployees[index]['employee_id'],
  },);

  // for (var record in records) {
  //   final checkInId = record['date']; // yyyy-MM-dd
  //
  //   // 2. Add checkIn record
  //   await employeeDocRef.collection("checkIns").doc(checkInId).set({
  //     "checkInTime": Timestamp.fromDate(DateTime.parse(record['checkIn'])),
  //     "checkOutTime": Timestamp.fromDate(DateTime.parse(record['checkOut'])),
  //     "earlyLeaveReason": record['earlyLeaveReason'],
  //     "lateReason": record['lateReason'],
  //     "status": "Present",
  //   }, SetOptions(merge: true));
  // }

  print("✅ Dummy attendance uploaded to Firestore!");
}

final List<Map<String, dynamic>> dummyEmployees = [
  {
    "email": "alicefernandez001@gmail.com",
    "name": "Alice Fernandez",
    "employee_id": "EMP2310",
    "createdAt": DateTime(2025, 3, 25),
    "endDate": DateTime(2025, 4, 29),
    "designation": "UI Designer",
    "department": "Design",
    "team": "Creative Squad",
    "phone": "9876543210",
  },
  {
    "email": "brianthomas002@gmail.com",
    "name": "Brian Thomas",
    "employee_id": "EMP0002",
    "createdAt": DateTime(2025, 3, 26),
    "endDate": DateTime(2025, 4, 29),
    "designation": "Backend Developer",
    "department": "Engineering",
    "team": "Backend Gurus",
    "phone": "9123456789",
  },
  {
    "email": "chloerivera003@gmail.com",
    "name": "Chloe Rivera",
    "employee_id": "EMP1023",
    "createdAt": DateTime(2025, 3, 27),
    "endDate": DateTime(2025, 4, 29),
    "designation": "QA Engineer",
    "department": "Testing",
    "team": "Bug Bashers",
    "phone": "9345672189",
  },
  {
    "email": "davidlopez004@gmail.com",
    "name": "David Lopez",
    "employee_id": "EMP0110",
    "createdAt": DateTime(2025, 3, 28),
    "endDate": DateTime(2025, 4, 29),
    "designation": "DevOps Engineer",
    "department": "Operations",
    "team": "Infra Ninjas",
    "phone": "9001234567",
  },
  {
    "email": "elizabethkim005@gmail.com",
    "name": "Elizabeth Kim",
    "employee_id": "EMP1001",
    "createdAt": DateTime(2025, 3, 25),
    "endDate": DateTime(2025, 4, 29),
    "designation": "Content Writer",
    "department": "Marketing",
    "team": "Content Champs",
    "phone": "9567890321",
  },
  {
    "email": "fionatan006@gmail.com",
    "name": "Fiona Tan",
    "employee_id": "EMP2003",
    "createdAt": DateTime(2025, 3, 24),
    "endDate": DateTime(2025, 4, 29),
    "designation": "UX Researcher",
    "department": "Design",
    "team": "Insight Explorers",
    "phone": "9211112345",
  },
  {
    "email": "georgeray007@gmail.com",
    "name": "George Ray",
    "employee_id": "EMP1706",
    "createdAt": DateTime(2025, 3, 25),
    "endDate": DateTime(2025, 4, 29),
    "designation": "Frontend Developer",
    "department": "Engineering",
    "team": "UI Wizards",
    "phone": "9004321876",
  },
  {
    "email": "hannahlin008@gmail.com",
    "name": "Hannah Lin",
    "employee_id": "EMP1610",
    "createdAt": DateTime(2025, 3, 26),
    "endDate": DateTime(2025, 4, 29),
    "designation": "HR Executive",
    "department": "Human Resources",
    "team": "People First",
    "phone": "9898989898",
  },
  {
    "email": "isaaczhang009@gmail.com",
    "name": "Isaac Zhang",
    "employee_id": "EMP1976",
    "createdAt": DateTime(2025, 3, 24),
    "endDate": DateTime(2025, 4, 29),
    "designation": "Support Engineer",
    "department": "Customer Support",
    "team": "Client Care",
    "phone": "9331234000",
  },
  {
    "email": "juliaramos010@gmail.com",
    "name": "Julia Ramos",
    "employee_id": "EMP1198",
    "createdAt": DateTime(2025, 3, 27),
    "endDate": DateTime(2025, 4, 29),
    "designation": "Product Manager",
    "department": "Product",
    "team": "Vision Makers",
    "phone": "9876540001",
  },
];
