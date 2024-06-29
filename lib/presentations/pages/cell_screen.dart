import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/presentations/widgets/list_info.dart';
import 'package:flutter_tips_app/presentations/widgets/main_drawer.dart';
import 'package:flutter_tips_app/presentations/widgets/money_edit.dart';
// import 'package:flutter_tips_app/presentations/widgets/list_info.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';

class CellScreen extends ConsumerWidget {
  const CellScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final team = ref.watch(teamProvider);
    void editTeamMoney(String method) {
      Navigator.of(context).pop();
      showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 900),
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => MoneyEdit(
          isEdit: method == 'edit',
        ),
      );
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
    void resetTeamMoney() {
      final teamNotifier = ref.read(teamProvider.notifier);
      teamNotifier.resetTeamMoney();
    }

    void showResetConfirmation() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Подтвердите сброс'),
              content: const Text('Обнулить данные?',
                  style: TextStyle(fontSize: 16)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Закрыть диалог
                  },
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () {
                    resetTeamMoney();
                    Navigator.of(context).pop(); // Закрыть диалог
                  },
                  child: const Text('Да'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
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
              ListInfo(
                  items: [
                InfoListItem(
                    label: team!.mainCurrencyName, value: team.mainCurrencySum),
                ...team.currencies.map((el) {
                  return InfoListItem(label: el.name, value: el.amount);
                })
              ].toList()),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Остаток:', style: currencyText1),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(team.getRemainders().toString(),
                                  style: currencyText1),
                            ])),
                    const Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Всего часов:', style: currencyText1),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(team.getTotalHours().toString(),
                                  style: currencyText1),
                            ])),
                    const Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('За один час:', style: currencyText1),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(team.getPerHour().truncate().toString(),
                                  style: currencyText1),
                            ])),
                  ])),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: showResetConfirmation,
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
