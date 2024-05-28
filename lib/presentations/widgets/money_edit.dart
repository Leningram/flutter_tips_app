import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class MoneyEdit extends ConsumerStatefulWidget {
  const MoneyEdit({super.key, required this.isEdit});

  final bool isEdit;
  @override
  ConsumerState<MoneyEdit> createState() {
    return _MoneyEditState();
  }
}

class _MoneyEditState extends ConsumerState<MoneyEdit> {
  final _mainCurrencyAmountController = TextEditingController();
  List<Currency> currencies = [];
  late List<TextEditingController> _currencyControllers;

  @override
  void initState() {
    super.initState();
    _currencyControllers = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final team = ref.watch(teamProvider);
    if (_currencyControllers.isEmpty) {
      _currencyControllers = List.generate(
        team.currencies.length,
        (index) => TextEditingController(),
      );
      if (widget.isEdit) {
        for (var i = 0; i < team.currencies.length; i++) {
          _currencyControllers[i].text = team.currencies[i].amount.toString();
        }
      }
    }
    if (widget.isEdit) {
      _mainCurrencyAmountController.text = team.mainCurrencySum.toString();
    }
  }

  @override
  void dispose() {
    _mainCurrencyAmountController.dispose();
    for (var controller in _currencyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleClose() {
    Navigator.of(context).pop();
  }

  void _handleOk() {
    final teamNotifier = ref.read(teamProvider.notifier);

    final mainCurrencyAmount =
        int.tryParse(_mainCurrencyAmountController.text) ?? 0;
    final moneyData = {teamNotifier.state.mainCurrencyName: mainCurrencyAmount};

    for (var i = 0; i < teamNotifier.state.currencies.length; i++) {
      final currency = teamNotifier.state.currencies[i];
      final amount = int.tryParse(_currencyControllers[i].text) ?? 0;
      moneyData[currency.name] = amount;
    }

    teamNotifier.addMoney(moneyData);
    print(moneyData);

    _handleClose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final team = ref.watch(teamProvider);
    return LayoutBuilder(
      builder: (builder, constraints) {
        return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
                child: Column(
                  children: [
                    Text(
                      widget.isEdit ? 'Изменить сумму' : 'Добавить сумму',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _mainCurrencyAmountController,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        counterText: '',
                        label: Align(
                          alignment: Alignment.centerRight,
                          child: Text(team.mainCurrencyName),
                        ),
                      ),
                    ),
                    ...List.generate(
                      team.currencies.length,
                      (index) {
                        final currency = team.currencies[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextField(
                            controller: _currencyControllers[index],
                            textAlign: TextAlign.right,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: Text(currency.name),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              _handleClose();
                            },
                            child: Text('Отмена',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .error
                                        .withAlpha(230),
                                    fontSize: 16))),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              _handleOk();
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
