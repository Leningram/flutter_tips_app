import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/utils/formatters.dart';

class CurrenciesSettings extends ConsumerStatefulWidget {
  const CurrenciesSettings({super.key});

  @override
  ConsumerState<CurrenciesSettings> createState() => _CurrenciesSettingsState();
}

class _CurrenciesSettingsState extends ConsumerState<CurrenciesSettings> {
  bool _isAddCurrencyLoading = false;
  late TextEditingController _newCurrencyNameController;
  late TextEditingController _newCurrencyRateController;

  @override
  void initState() {
    super.initState();

    _newCurrencyNameController = TextEditingController(
      text: '',
    );
    _newCurrencyRateController = TextEditingController(
      text: '0',
    );
  }

  @override
  void dispose() {
    _newCurrencyNameController.dispose();
    _newCurrencyRateController.dispose();
    super.dispose();
  }

  Future<void> _addCurrency() async {
    if (_newCurrencyNameController.text.isEmpty) {
      return;
    }
    _isAddCurrencyLoading = true;
    try {
      await ref.read(teamProvider.notifier).addCurrency(
          _newCurrencyNameController.text,
          int.tryParse(_newCurrencyRateController.text));
    } finally {
      _isAddCurrencyLoading = false;
    }
  }

  Future<void> _removeCurrency(String id) async {
    ref.read(teamProvider.notifier).removeCurrency(id);
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
  @override
  Widget build(BuildContext context) {
    final team = ref.watch(teamProvider);
    return Column(children: [
      const Text('Валюта',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10,
      ),
      if (team != null)
        ListView.separated(
          shrinkWrap: true,
          itemCount: team.currencies.length,
          itemBuilder: (context, index) {
            final item = team.currencies[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: ListTile(
                title: Text(capitalize(item.name)),
                trailing: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () =>
                      _showRemoveCurrencyDialog(item.id, capitalize(item.name)),
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
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: TextFormField(
                controller: _newCurrencyNameController,
                decoration:
                    const InputDecoration(label: Text('Название валюты')),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _newCurrencyRateController,
                decoration: const InputDecoration(label: Text('Курс валюты')),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      TextButton(
          onPressed: _isAddCurrencyLoading ? null : _addCurrency,
          child: const Text('Добавить')),
    ]);
  }
}
