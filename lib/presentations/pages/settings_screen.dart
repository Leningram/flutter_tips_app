import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _form = GlobalKey<FormState>();
  late TextEditingController _hoursDefaultController;
  late TextEditingController _advanceStepController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);

    _hoursDefaultController = TextEditingController(
      text: settings.hoursDefault.toString(),
    );
    _advanceStepController = TextEditingController(
      text: settings.advanceStep.toString(),
    );
  }

  @override
  void dispose() {
    _hoursDefaultController.dispose();
    _advanceStepController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    setState(() {
      _isLoading = true;
    });
    final advanceStep = int.parse(_advanceStepController.text);
    final hoursDefault = int.parse(_hoursDefaultController.text);
    await ref.read(settingsProvider.notifier).saveSettings(
        {'advanceStep': advanceStep, 'hoursDefault': hoursDefault});
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _hoursDefaultController,
                decoration: const InputDecoration(
                    label: Text('Кол-во часов по умолчанию')),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _advanceStepController,
                decoration: const InputDecoration(
                    label: Text('Шаг добавления в поле аванса')),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveSettings,
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
