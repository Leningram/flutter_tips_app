import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/providers/settings_provider.dart';

class CommonSettings extends ConsumerStatefulWidget {
  const CommonSettings({super.key});

  @override
  ConsumerState<CommonSettings> createState() => _CommonSettingsState();
}

class _CommonSettingsState extends ConsumerState<CommonSettings> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  late TextEditingController _hoursDefaultController;
  late TextEditingController _advanceStepController;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    if (settings != null) {
      _hoursDefaultController = TextEditingController(
        text: settings.hoursDefault.toString(),
      );
      _advanceStepController = TextEditingController(
        text: settings.advanceStep.toString(),
      );
    } else {
      _hoursDefaultController = TextEditingController(
        text: '',
      );
      _advanceStepController = TextEditingController(
        text: '',
      );
    }
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
    return Column(
      children: [
        Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _hoursDefaultController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Кол-во часов по умолчанию')),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _advanceStepController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Шаг добавления в поле аванса')),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: _isLoading ? null : _saveSettings,
                child: const Text('Сохранить'),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
