import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';
import 'package:flutter_tips_app/presentations/widgets/user_info.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/providers/user_provider.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
        title: const Text('Tips App'),
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
       bottomNavigationBar: BottomNavigationBar(
        onTap: (page) {},
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Таблица'),
          BottomNavigationBarItem(icon: Icon(Icons.all_inbox_outlined), label: 'Ячейка'),
        ],
      ),
    );
  }
}
