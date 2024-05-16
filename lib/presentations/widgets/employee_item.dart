import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/employee.dart';

class EmployeeItem extends StatefulWidget {
  const EmployeeItem({required this.employeeData, super.key});

  final Employee employeeData;

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.employeeData.name);
  }
}
