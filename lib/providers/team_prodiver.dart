import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/models/team.dart';

class TeamNotifier extends StateNotifier<Team> {
  TeamNotifier()
      : super(Team(
          name: '',
          admin: '',
          mainCurrencyName: '',
          mainCurrencySum: 0,
          currencies: [],
          employees: [],
        ));

  void setTeam(Team team) {
    state = team;
  }

  Employee? getEmployeeByName(String name) {
    return state.employees
        .firstWhereOrNull((employee) => employee.name == name);
  }

  void addMoney(Map<String, int> moneyData) {
    var newState = Team(
      name: state.name,
      admin: state.admin,
      mainCurrencyName: state.mainCurrencyName,
      mainCurrencySum: state.mainCurrencySum,
      currencies: List.from(state.currencies),
      employees: List.from(state.employees),
    );

    if (moneyData.containsKey(newState.mainCurrencyName)) {
      newState.mainCurrencySum += moneyData[newState.mainCurrencyName]!;
    }

    for (var entry in moneyData.entries) {
      var currencyName = entry.key;
      var amountToAdd = entry.value;

      var currency = newState.currencies.firstWhere(
        (c) => c.name == currencyName,
        orElse: () => Currency(name: currencyName, rate: 1, amount: 0),
      );

      if (currency.name == currencyName) {
        currency.amount += amountToAdd;
      } else {
        newState.currencies
            .add(Currency(name: currencyName, rate: 1, amount: amountToAdd));
      }
    }
    newState.countEmployeesMoney();
    state = newState;
  }

  void setMoney(Map<String, int> moneyData) {
    var newState = Team(
      name: state.name,
      admin: state.admin,
      mainCurrencyName: state.mainCurrencyName,
      mainCurrencySum: 0,
      currencies: List.from(state.currencies),
      employees: List.from(state.employees),
    );

    if (moneyData.containsKey(newState.mainCurrencyName)) {
      newState.mainCurrencySum += moneyData[newState.mainCurrencyName]!;
    }

    for (var entry in moneyData.entries) {
      var currencyName = entry.key;
      var amountToAdd = entry.value;

      var currency = newState.currencies.firstWhere(
        (c) => c.name == currencyName,
        orElse: () => Currency(name: currencyName, rate: 1, amount: 0),
      );

      if (currency.name == currencyName) {
        currency.amount = amountToAdd;
      } else {
        newState.currencies
            .add(Currency(name: currencyName, rate: 1, amount: amountToAdd));
      }
    }
    newState.countEmployeesMoney();
    state = newState;
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, Team>((ref) {
  return TeamNotifier();
});
