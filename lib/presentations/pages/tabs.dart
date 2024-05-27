import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/pages/cell_screen.dart';
import 'package:flutter_tips_app/presentations/pages/main_screen.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/providers/user_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = const MainScreen();

    if (_selectedPageIndex == 1) {
      activePage = const CellScreen();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(teamProvider.notifier).setTeam(mockTeam);
      ref.read(userProvider.notifier).setUserById('Тимур');
    });

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Таблица'),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox_outlined), label: 'Ячейка'),
        ],
      ),
    );
  }
}
