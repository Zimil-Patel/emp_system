import 'package:emp_system/core/model/employee_model.dart';
import 'package:emp_system/screens/supervisor/stats%20page/stats_page.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key,});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<EmployeeModel> employees = supervisorController.employeeList.where((emp) => emp.isVerified == true).toList();
        return ListView.separated(
        itemCount: employees.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return EmployeeTile(employee: employees[index],);
        },
      );}
    );
  }
}

// Employee Tile Widget
class EmployeeTile extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: TextStyle(fontSize: 14.h)),
          Text(employee.employeeId, style: TextStyle(fontSize: 14.h, color: Colors.grey)),
        ],
      ),
      trailing: const Icon(Icons.remove_red_eye, color: Colors.grey),
      onTap: () async {
        await statsController.fetchStats(employee.email);
        Get.to(() => StatsPage(employee: employee,));
      }, // Add action on tap
    );
  }
}
