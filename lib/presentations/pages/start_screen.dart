import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (user != null) UserInfo(user: user),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 1,
          thickness: 2,
        ),
        EmployeeList(employees: employees)
      ],
    );
  }
}
