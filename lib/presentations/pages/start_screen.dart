import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/utils/formatters.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_item.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({required this.employees, super.key});
  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Дениска',
                  style: bodyText2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  formatNumber(16720),
                  style: titleText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      'часов:',
                      style: bodyText1,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '45',
                      style: bodyText1,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'аванс:',
                      style: bodyText1,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '12000',
                      style: bodyText1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 1,
          thickness: 2,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            itemCount: employees.length,
            itemBuilder: (ctx, index) => Container(
                color: index % 2 == 0 ? Color.fromARGB(30, 151, 151, 151) : null,
                child: EmployeeItem(employeeData: employees[index])),
          ),
        ),
      ],
    );
  }
}
