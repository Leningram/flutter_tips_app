import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/providers/settings_provider.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
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
  late TextEditingController _newCurrencyNameController;
  late TextEditingController _newCurrencyRateController;

  bool _isLoading = false;
  bool _isAddCurrencyLoading = false;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);

    _hoursDefaultController = TextEditingController(
      text: settings.hoursDefault.toString(),
    );
    _newCurrencyNameController = TextEditingController(
      text: '',
    );
    _newCurrencyRateController = TextEditingController(
      text: '0',
    );
    _advanceStepController = TextEditingController(
      text: settings.advanceStep.toString(),
    );
  }

  @override
  void dispose() {
    _hoursDefaultController.dispose();
    _advanceStepController.dispose();
    _newCurrencyNameController.dispose();
    _newCurrencyRateController.dispose();
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
    if (_newCurrencyNameController.text.isEmpty) {
      return;
    }
    _isAddCurrencyLoading = true;
    try {
      await ref
          .read(teamProvider.notifier)
          .addCurrency(
          _newCurrencyNameController.text,
          int.tryParse(_newCurrencyRateController.text));
    } finally {
      _isAddCurrencyLoading = false;
    }
  }

  Future<void> _showRemoveCurrencyDialog(String id, String name) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить валюту'),
          content: Text('Вы уверены, что хотите удалить валюту $name?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removeCurrency(id);
              },
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeCurrency(String id) async {
    ref.read(teamProvider.notifier).removeCurrency(id);
  }

  @override
  Widget build(BuildContext context) {
    final team = ref.watch(teamProvider);
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
                if (team != null)
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: team.currencies.length,
                    itemBuilder: (context, index) {
                      final item = team.currencies[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: ListTile(
                          title: Text(capitalize(item.name)),
                          trailing: TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () => _showRemoveCurrencyDialog(
                                item.id, capitalize(item.name)),
                            icon: const Icon(Icons.delete),
                            label: const Text('Удалить'),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: _newCurrencyNameController,
                          decoration: const InputDecoration(
                              label: Text('Название валюты')),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _newCurrencyRateController,
                          decoration:
                              const InputDecoration(label: Text('Курс валюты')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: _isAddCurrencyLoading ? null : _addCurrency,
                    child: const Text('Добавить')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
