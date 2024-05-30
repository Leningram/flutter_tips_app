import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';
import 'package:flutter_tips_app/presentations/widgets/user_info.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/providers/user_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final team = ref.watch(teamProvider);
    final user = ref.watch(userProvider);
    Employee? userEmployee;
    if (user != null) {
      userEmployee = team.employees.firstWhere(
        (employee) => employee.name == user.name,
        orElse: () => Employee(
          name: '',
          advance: 0,
          hours: 0,
          image: '',
          percent: 0.0,
          totalTips: 0,
        ),
      );
    }

    void openAddEmployee() {
      showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 900),
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewEmployee(onAddEmployee: (employee) {}),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Таблица'),
        actions: [
          IconButton(
              onPressed: () {
                openAddEmployee();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if (userEmployee != null) UserInfo(user: userEmployee),
          const Divider(
            height: 1,
            thickness: 2,
          ),
          const EmployeeList()
        ],
      ),
    );
  }
}
