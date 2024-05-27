import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/presentations/widgets/money_info.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';

class CellScreen extends ConsumerWidget {
  const CellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = ref.watch(teamProvider);
    final currencies = team.currencies;

    void editTeamMoney(String method) {
      Navigator.of(context).pop();
    }

    Future<void> showMoneyAddChoice(BuildContext context) {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              content: const Text(
                'Выберите действие',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Изменить'),
                  onPressed: () {
                    editTeamMoney('edit');
                  },
                ),
                ElevatedButton(
                  child: const Text('Добавить'),
                  onPressed: () {
                    editTeamMoney('add');
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ячейка'),
        actions: [
          IconButton(
            onPressed: () {
              showMoneyAddChoice(context);
            },
            icon: const Icon(Icons.add_chart),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MoneyInfo(team: team),
              const SizedBox(
                height: 30,
              ),
              const Card(
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Остаток:', style: currencyText1),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('1290', style: currencyText1),
                              ])),
                      Divider(height: 1, thickness: 2),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Всего часов:', style: currencyText1),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('129', style: currencyText1),
                              ])),
                      Divider(height: 1, thickness: 2),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('За один час:', style: currencyText1),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('1290', style: currencyText1),
                              ])),
                    ])),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer),
                child: Text(
                  'Сбросить',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
