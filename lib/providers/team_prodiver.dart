import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/models/team.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'tips.db'),
      onCreate: (db, version) async {
    await db.execute(
       '''
        CREATE TABLE teams (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          admin TEXT,
          mainCurrencyName TEXT,
          mainCurrencySum INTEGER
        )
      ''');
        await db.execute('''
        CREATE TABLE employees (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          teamId INTEGER,
          name TEXT,
          advance INTEGER,
          hours INTEGER,
          image TEXT,
          percent REAL,
          totalTips INTEGER,
          FOREIGN KEY (teamId) REFERENCES teams (id) ON DELETE CASCADE
        )
      ''');
      await db.execute('''
        CREATE TABLE currencies (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          teamId INTEGER,
          name TEXT,
          rate REAL,
          amount INTEGER,
          FOREIGN KEY (teamId) REFERENCES teams (id) ON DELETE CASCADE
        )
      ''');
  }, version: 1);
  return db;
}

class EmployeeData {
  final int hours;
  final int advance;
  EmployeeData(this.advance, this.hours);
}

class TeamNotifier extends StateNotifier<Team> {
  TeamNotifier()
      : super(Team(
          id: 0,
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
      id: state.id,
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
        orElse: () => Currency(
            teamId: newState.id, name: currencyName, rate: 1, amount: 0),
      );

      if (currency.name == currencyName) {
        currency.amount += amountToAdd;
      } else {
        newState.currencies
            .add(Currency(teamId: newState.id,  name: currencyName, rate: 1, amount: amountToAdd));
      }
    }
    newState.countEmployeesMoney();
    state = newState;
  }

  void setMoney(Map<String, int> moneyData) {
    var newState = Team(
      id: state.id,
      name: state.name,
      admin: state.admin,
      mainCurrencyName: state.mainCurrencyName,
      mainCurrencySum: 0,
      currencies: List.from(state.currencies),
    );

    if (moneyData.containsKey(newState.mainCurrencyName)) {
      newState.mainCurrencySum += moneyData[newState.mainCurrencyName]!;
    }

    for (var entry in moneyData.entries) {
      var currencyName = entry.key;
      var amountToAdd = entry.value;

      var currency = newState.currencies.firstWhere(
        (c) => c.name == currencyName,
        orElse: () => Currency(teamId: newState.id, name: currencyName, rate: 1, amount: 0),
      );

      if (currency.name == currencyName) {
        currency.amount = amountToAdd;
      } else {
        newState.currencies
            .add(Currency(teamId: newState.id, name: currencyName, rate: 1, amount: amountToAdd));
      }
    }
    newState.countEmployeesMoney();
    state = newState;
  }

  void resetTeamMoney() {
    var newState = Team(
       id: state.id,
      name: state.name,
      admin: state.admin,
      mainCurrencyName: state.mainCurrencyName,
      mainCurrencySum: 0,
      currencies: List.from(state.currencies),
      employees: state.employees.map((employee) {
        if (employee.totalTips < 0) {
          // Make a copy of the employee object and update its data
          return Employee(
            id: employee.id,
            teamId: employee.teamId,
            name: employee.name,
            hours: employee.hours,
            advance: -employee.totalTips,
            image: employee.image,
            percent: employee.percent,
            totalTips: employee.totalTips, // Ensure totalTips remains unchanged
          );
        }
        return employee; // Return unmodified employee if name doesn't match
      }).toList(),
    );

    for (var currency in newState.currencies) {
      currency.amount = 0;
    }
    newState.countEmployeesMoney();
    state = newState;
  }

  void setEmployeeData(String name, EmployeeData data) {
    var newState = Team(
       id: state.id,
      name: state.name,
      admin: state.admin,
      mainCurrencyName: state.mainCurrencyName,
      mainCurrencySum: state.mainCurrencySum,
      currencies: List.from(state.currencies),
      employees: state.employees.map((employee) {
        if (employee.name == name) {
          // Make a copy of the employee object and update its data
          return Employee(
            id: employee.id,
            teamId: employee.teamId,
            name: employee.name,
            hours: data.hours,
            advance: data.advance,
            image: employee.image,
            percent: employee.percent,
            totalTips: employee.totalTips, // Ensure totalTips remains unchanged
          );
        }
        return employee; // Return unmodified employee if name doesn't match
      }).toList(),
    );
    newState.countEmployeesMoney(); // Recalculate employee money totals
    state = newState; // Update the state with th
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, Team>((ref) {
  return TeamNotifier();
});
