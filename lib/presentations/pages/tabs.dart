import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/pages/cell_screen.dart';
import 'package:flutter_tips_app/presentations/pages/main_screen.dart';
import 'package:flutter_tips_app/presentations/pages/settings_screen.dart';
import 'package:flutter_tips_app/presentations/widgets/main_drawer.dart';
import 'package:flutter_tips_app/presentations/widgets/money_edit.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';
// import 'package:flutter_tips_app/providers/team_prodiver.dart';
// import 'package:flutter_tips_app/providers/user_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'settings') {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
    }
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

  void editTeamMoney(String method) {
    Navigator.of(context).pop();
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 900),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => MoneyEdit(
        isEdit: method == 'edit',
      ),
    );
  }

  Future<void> showMoneyAddChoice(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            content: const Text(
              'Выберите действие',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Изменить'),
                onPressed: () {
                  editTeamMoney('edit');
                },
              ),
              ElevatedButton(
                child: const Text('Добавить'),
                onPressed: () {
                  editTeamMoney('add');
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;

    if (_selectedPageIndex == 0) {
      activePage = MainScreen(
        actions: [
          IconButton(
              onPressed: () {
                openAddEmployee();
              },
              icon: const Icon(Icons.person_add))
        ],
      );
    } else {
      activePage = CellScreen(
        actions: [
          IconButton(
            onPressed: () {
              showMoneyAddChoice(context);
            },
            icon: const Icon(Icons.add_chart),
          )
        ],
      );
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (ref.watch(teamProvider).name == '') {
    //     ref.read(teamProvider.notifier).setTeam(mockTeam);
    //     ref.read(userProvider.notifier).setUserById('Тимур');
    //   }
    // });

    return Scaffold(
      body: activePage,
      appBar: AppBar(
          actions: activePage is MainScreen
              ? (activePage).actions
              : (activePage as CellScreen).actions),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        enableFeedback: true,
        currentIndex: _selectedPageIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Таблица'),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox_outlined), label: 'Ячейка'),
        ],
      ),
    );
  }
}
