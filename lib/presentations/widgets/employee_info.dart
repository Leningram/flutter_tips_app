import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/presentations/widgets/counter_input.dart';

class EmployeeInfo extends StatefulWidget {
  const EmployeeInfo({
    super.key,
    required this.employee,
    required this.advanceController,
    required this.hoursController,
  });
  final Employee employee;
  final TextEditingController hoursController;
  final TextEditingController advanceController;

  @override
  State<EmployeeInfo> createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 46),
          child: Column(
            children: [
              CounterInput(controller: widget.hoursController, label: 'Часы'),
              const SizedBox(
                height: 20,
              ),
              CounterInput(
                controller: widget.advanceController,
                label: 'Аванс',
                step: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
