import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_item.dart';
import 'package:flutter_tips_app/presentations/widgets/empty_list.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class EmployeeList extends ConsumerWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = ref.watch(teamProvider);
    Widget mainContent = const EmptyList();
    if (team != null && team.employees.isNotEmpty) {
      mainContent = Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: ListView.builder(
          itemCount: team.employees.length,
          itemBuilder: (ctx, index) {
            // final bool hasBackground = index % 2 == 0;
            return Column(
              children: [
                EmployeeItem(
                    employeeId: team.employees[index].id,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      );
    }

    return Expanded(
      child: mainContent,
    );
  }
}
