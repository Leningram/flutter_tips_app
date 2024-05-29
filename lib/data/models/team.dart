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
    employees = employees
        .map((e) => Employee(
              name: e.name,
              advance: e.advance,
              hours: e.hours,
              image: e.image,
              percent: e.percent,
              totalTips: e.totalTips,
              team: this, // Передаем текущий объект Team
            ))
        .toList();
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

  int getRemainders() {
    int remainder = 0;
    int totalTips = 0;
    for (final employee in employees) {
      totalTips += employee.totalTips;
    }
    int currenciesSum = 0;
    for (final currency in currencies) {
      currenciesSum += currency.amount * currency.rate;
    }

    int totalMoney = currenciesSum + mainCurrencySum;
    remainder = totalMoney - totalTips;
    return remainder;
  }

  double getPerHour() {
    int currenciesSum = 0;
    int totalHours = employees.fold(0, (sum, employee) => sum + employee.hours);
    if (totalHours == 0) {
      return 0;
    }
    for (final currency in currencies) {
      currenciesSum += currency.amount * currency.rate;
    }
    int totalMoney = currenciesSum + mainCurrencySum;
    double perHour = totalMoney / totalHours;
    return perHour;
  }

  void countEmployeesMoney() {
    final perHour = getPerHour();
    for (final employee in employees) {
      employee.setTotalTips(perHour);
    }
  }
}
