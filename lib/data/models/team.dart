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
    countEmployeesMoney(); // Вызов метода после инициализации
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

  void countEmployeesMoney() {
    int currenciesSum = 0;
    int totalHours = employees.fold(0, (sum, employee) => sum + employee.hours);
    for (final currency in currencies) {
      currenciesSum += currency.amount * currency.rate;
    }
    int totalMoney = currenciesSum + mainCurrencySum;
    if (totalHours != 0) {
      int perHour = ((totalMoney / totalHours).floor() ~/ 10) * 10;
      for (final employee in employees) {
        employee.setTotalTips(perHour);
      }
    }
  }
}
