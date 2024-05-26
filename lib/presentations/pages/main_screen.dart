import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';
import 'package:flutter_tips_app/presentations/widgets/user_info.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/providers/user_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(teamProvider.notifier).setTeam(mockEmployees);
      ref.read(userProvider.notifier).setUserById('Тимур');
    });
    final employees = ref.watch(teamProvider);
    final user = ref.watch(userProvider);

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
          if (user != null) UserInfo(user: user),
          const Divider(
            height: 1,
            thickness: 2,
          ),
          EmployeeList(employees: employees)
        ],
      ),
    );
  }
}
