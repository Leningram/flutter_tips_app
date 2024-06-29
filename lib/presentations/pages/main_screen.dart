import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/team.dart';
import 'package:flutter_tips_app/presentations/pages/new_team_screen.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
import 'package:flutter_tips_app/presentations/widgets/main_drawer.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  Widget? activePage;

  @override
  void initState() {
    super.initState();
    final team = ref.read(teamProvider);
    if (team == null) {
      ref.read(teamProvider.notifier).fetchTeam();
    }
  }

  void openAddEmployee() {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 900),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewEmployee(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                openAddEmployee();
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final teamStream = ref.watch(teamProvider.notifier).fetchTeam();
          return StreamBuilder<Team?>(
            stream: teamStream,
            builder: (context, snapshot) {
              if (ref.watch(teamProvider) != null) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 1,
                      thickness: 2,
                    ),
                    EmployeeList(),
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading data'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const NewTeamScreen();
              } else {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 1,
                      thickness: 2,
                    ),
                    EmployeeList(),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
