import 'package:emp_system/screens/supervisor/stats%20page/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeList extends StatelessWidget {
  final List<String> employees;
  const EmployeeList({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: employees.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return EmployeeTile(name: employees[index]);
      },
    );
  }
}

// Employee Tile Widget
class EmployeeTile extends StatelessWidget {
  final String name;
  const EmployeeTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.remove_red_eye, color: Colors.grey),
      onTap: () {
        Get.to(() => StatsPage());
      }, // Add action on tap
    );
  }
}
