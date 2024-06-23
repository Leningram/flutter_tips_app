import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
// import 'package:flutter_tips_app/presentations/widgets/user_info.dart';
// import 'package:flutter_tips_app/providers/team_prodiver.dart';
// import 'package:flutter_tips_app/providers/user_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key, required this.actions});
  final List<Widget> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final team = ref.watch(teamProvider);
    // final user = ref.watch(userProvider);
    Employee? userEmployee;
 

    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (userEmployee != null) UserInfo(user: userEmployee),
          Divider(
            height: 1,
            thickness: 2,
          ),
          EmployeeList()
        ],
      ),
    );
  }
}
