import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/presentations/widgets/list_info.dart';
import 'package:flutter_tips_app/providers/settings_provider.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';
import 'package:flutter_tips_app/utils/formatters.dart';

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
  late TextEditingController _newCurrencyController;

  bool _isLoading = false;
  bool _isAddCurrencyLoading = false;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);

    _hoursDefaultController = TextEditingController(
      text: settings.hoursDefault.toString(),
    );
    _newCurrencyController = TextEditingController(
      text: '',
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

  Future<void> _addCurrency() async {
    _isAddCurrencyLoading = true;
    try {
      await ref
          .read(teamProvider.notifier)
          .addCurrency(_newCurrencyController.text, 100);
    } finally {
      _isAddCurrencyLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final team = ref.read(teamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                if (team != null)
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: team.currencies.length,
                    itemBuilder: (context, index) {
                      final item = team.currencies[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(capitalize(item.name)),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, thickness: 2),
                  ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveSettings,
                  child: const Text('Сохранить'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _newCurrencyController,
                  decoration:
                      const InputDecoration(label: Text('Добавить валюту')),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: _isAddCurrencyLoading ? null : _addCurrency,
                    child: const Text('Добавить'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
