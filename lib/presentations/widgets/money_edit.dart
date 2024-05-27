import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/utils/formatters.dart';

class MoneyEdit extends ConsumerStatefulWidget {
  const MoneyEdit({super.key, required this.isEdit});

  final bool isEdit;
  ConsumerState<MoneyEdit> createState() {
    return _MoneyEditState();
  }
}

class _MoneyEditState extends ConsumerState<MoneyEdit> {
  final _mainCurrencyAmountController = TextEditingController();
  List<Currency> currencies = [];
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final team = ref.watch(teamProvider);
    _mainCurrencyAmountController.text = team.mainCurrencySum.toString();
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
                      widget.isEdit ? 'Изменить сумму': 'Добавить сумму',
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
                      decoration: InputDecoration(
                        label: Text(capitalize(team.mainCurrencyName)),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
