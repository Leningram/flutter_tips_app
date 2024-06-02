import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text('Кол-во часов по умолчанию')
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                label: Text('Шаг добавления в поле аванса')
              ),
            )
          ],
        ),
      ),
    );
  }
}
