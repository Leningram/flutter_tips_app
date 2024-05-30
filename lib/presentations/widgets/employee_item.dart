import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/utils/formatters.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_info.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class EmployeeItem extends ConsumerStatefulWidget {
  const EmployeeItem(
      {required this.employeeName, this.backgroundColor, super.key});

  final String employeeName;
  final Color? backgroundColor;

  @override
  ConsumerState<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends ConsumerState<EmployeeItem> {
  void editEmployeeData(String name, EmployeeData data) {
    ref.watch(teamProvider.notifier).setEmployeeData(name, data);
  }

  Future<void> _dialogBuilder(BuildContext context) async {
    TextEditingController hoursController = TextEditingController();
    TextEditingController advanceController = TextEditingController();
    final employeeData =
        ref.watch(teamProvider.notifier).getEmployeeByName(widget.employeeName);
    if (employeeData == null) {
      // Обработка случая, если employeeData не найден
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ошибка'),
            content: const Text('Сотрудник не найден.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ок'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    hoursController =
        TextEditingController(text: employeeData.hours.toString());
    advanceController =
        TextEditingController(text: employeeData.advance.toString());
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            title: Text(employeeData.name),
            content: EmployeeInfo(
              employee: employeeData,
              advanceController: advanceController,
              hoursController: hoursController,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              OutlinedButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ок'),
                onPressed: () {
                  final newData = EmployeeData(
                    int.parse(advanceController.text),
                    int.parse(hoursController.text),
                  );
                  editEmployeeData(employeeData.name, newData);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final employeeData =
        ref.watch(teamProvider.notifier).getEmployeeByName(widget.employeeName);

    if (employeeData == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text('Сотрудник не найден'),
      );
    }
    return InkWell(
      onTap: () => _dialogBuilder(context),
      child: Ink(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employeeData.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.watch_later_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                employeeData.hours.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatNumber(employeeData.getTotalTips())
                                .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              const Text(
                                'аванс: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(120, 0, 0, 0),
                                ),
                              ),
                              Text(
                                formatNumber(employeeData.advance).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(120, 0, 0, 0),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
