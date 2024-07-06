import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/team.dart';
import 'package:flutter_tips_app/presentations/pages/new_team_screen.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
import 'package:flutter_tips_app/presentations/widgets/main_drawer.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  Widget? activePage;
  ScreenshotController screenshotController = ScreenshotController();
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

  void takeScreenshot() async {
    final image = await screenshotController.capture(pixelRatio: 2);
    Share.shareXFiles([XFile.fromData(image!, mimeType: 'png')]);
  }

  @override
  Widget build(BuildContext context) {
    final team = ref.watch(teamProvider);
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: team != null ? Text(team.name) : null,
        actions: [
          IconButton(
              onPressed: () {
                takeScreenshot();
              },
              icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill))
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final teamStream = ref.watch(teamProvider.notifier).fetchTeam();
          return StreamBuilder<Team?>(
            stream: teamStream,
            builder: (context, snapshot) {
              if (ref.watch(teamProvider) != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 1,
                      thickness: 2,
                    ),
                    EmployeeList(screenshotController: screenshotController),
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
