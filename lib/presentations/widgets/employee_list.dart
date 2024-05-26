import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_item.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key, required this.employees});

  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (ctx, index) => Container(
            color: index % 2 == 0
                ? Theme.of(context).colorScheme.primaryContainer
                : null,
            child: EmployeeItem(employeeData: employees[index])),
      ),
    );
  }
}
