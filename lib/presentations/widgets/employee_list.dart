import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_tips_app/presentations/widgets/employee_item.dart';
import 'package:flutter_tips_app/presentations/widgets/empty_list.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class EmployeeList extends ConsumerWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = ref.watch(teamProvider);
    Widget mainContent = const EmptyList();

    if (team != null) {
      const Center(child: Text('Employees list'));
      // mainContent = ListView.builder(
      //   itemCount: team.employees.length,
      //   itemBuilder: (ctx, index) {
      //     final bool hasBackground = index % 2 == 0;
      //     return EmployeeItem(
      //       employeeName: team.employees[index].name,
      //       backgroundColor: hasBackground
      //           ? Theme.of(context).colorScheme.primaryContainer
      //           : null,
      //     );
      //   },
      // ),
    }

    return Expanded(
      child: mainContent,
    );
  }
}
