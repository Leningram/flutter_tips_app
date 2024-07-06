import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';

class Team {
  String id;
  final String name;
  final String adminId;
  final String mainCurrencyName;
  List<Employee> employees;
  int mainCurrencySum;
  List<Currency> currencies;
  Team({
    required this.id,
    required this.name,
    required this.adminId,
    required this.mainCurrencyName,
    required this.mainCurrencySum,
    required this.currencies,
    required this.employees,
  });

  int getTeamTotal() {
    var result = mainCurrencySum;
    for (var currency in currencies) {
      result += currency.rate * currency.amount;
    }
    return result;
  }

  int getRemainders() {
    final totalMoney = getTeamTotal();
    int employeesMoney = 0;
    for (final employee in employees) {
      employeesMoney += employee.getTotalTips();
    }
    final remainder = totalMoney - employeesMoney;
    return remainder;
  }

  int getTotalHours() {
    int totalHours = employees.fold(0, (sum, employee) => sum + employee.hours);
    return totalHours;
  }

  int getPerHour() {
    int totalHours = getTotalHours();
    if (totalHours == 0) {
      return 0;
    }

    double perHour = getTeamTotal() / totalHours;
    return perHour.truncate();
  }

  void countEmployeesMoney() {
    final perHour = getPerHour();
    for (final employee in employees) {
      employee.setTotalTips(perHour);
    }
  }
}
