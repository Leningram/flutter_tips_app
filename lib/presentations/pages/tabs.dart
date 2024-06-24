import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/pages/cell_screen.dart';
import 'package:flutter_tips_app/presentations/pages/main_screen.dart';
import 'package:flutter_tips_app/presentations/pages/settings_screen.dart';
import 'package:flutter_tips_app/presentations/widgets/main_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage;

    if (_selectedPageIndex == 0) {
      activePage = const MainScreen();
    } else {
      activePage = const CellScreen();
    }

    return Scaffold(
      body: activePage,
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
