import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';

class Team {
  final String name;
  final String admin;
  final String mainCurrencyName;
  int mainCurrencySum;
  List<Currency> currencies;
  List<Employee> employees;

  Team({
    required this.name,
    required this.admin,
    required this.mainCurrencyName,
    required this.mainCurrencySum,
    required this.currencies,
    required this.employees,
  }) {
    for (var employee in employees) {
      employee.team = this;
    }
  }

  int getTeamTotal() {
    var result = mainCurrencySum;
    for (var currency in currencies) {
      result += currency.rate * currency.amount;
    }
    return result;
  }

  int getTotalHours() {
    int totalHours = 0;
    for (var employee in employees) {
      totalHours += employee.hours;
    }
    return totalHours;
  }

  void addMoney(Map<String, int> moneyData) {
    moneyData.forEach((currencyName, amountToAdd) {
      final currency = currencies.firstWhere((c) => c.name == currencyName);
      if (!currencies.contains(currency)) {
        return;
      }
      currency.amount += amountToAdd;
    });
  }
}
