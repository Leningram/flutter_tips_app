import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_item.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({required this.employees, super.key});
  final List<Employee> employees;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Master'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Всего: \$200'),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.watch),
                      SizedBox(width: 5,),
                      Text('45'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (ctx, index) =>
                  EmployeeItem(employeeData: employees[index]),
            ),
          ),
        ],
      ),
    );
  }
}
