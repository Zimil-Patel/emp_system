import 'package:emp_system/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleOptions extends StatelessWidget {
  const RoleOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // EMPLOYEE
        RoleOptionButton(role: 'Employee'),

        // SUPERVISOR
        RoleOptionButton(role: 'Supervisor'),
      ],
    );
  }
}

class RoleOptionButton extends StatelessWidget {
  const RoleOptionButton({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {

      },
      child: CircleAvatar(
        radius: 50.h,
        backgroundColor: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [

              // ROLE LOGO
              AspectRatio(
                aspectRatio: 1.8,
                child: Image.asset('assets/images/${role.toLowerCase()}.png'),
              ),

              // ROLE NAME
              Text(
                role,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
