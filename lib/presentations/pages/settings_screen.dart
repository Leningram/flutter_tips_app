import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/presentations/pages/common_settings.dart';
import 'package:flutter_tips_app/presentations/pages/currencies_settings.dart';
import 'package:flutter_tips_app/presentations/pages/employees_settings.dart';
import 'package:flutter_tips_app/presentations/widgets/main_drawer.dart';
import 'package:flutter_tips_app/providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  int _activePageIndex = 0;

  void _setPage(page) {
    setState(() {
      _activePageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CommonSettings();
    if (_activePageIndex == 0) {
      activePage = const CommonSettings();
    }
    if (_activePageIndex == 1) {
      activePage = const CurrenciesSettings();
    }
    if (_activePageIndex == 2) {
      activePage = const EmployeesSettings();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setPage,
        currentIndex: _activePageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Параметры'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Валюты'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Сотрудники'),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: activePage,
        ),
      ),
    );
  }
}
