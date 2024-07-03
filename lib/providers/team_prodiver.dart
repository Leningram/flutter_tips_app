import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/models/team.dart';
import 'package:collection/collection.dart';

class EmployeeData {
  final int hours;
  final int advance;
  EmployeeData(this.advance, this.hours);
}

class TeamNotifier extends StateNotifier<Team?> {
  TeamNotifier() : super(null);

  Stream<Team?> fetchTeam() async* {
    if (state != null) {
      yield (state);
      return;
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('adminId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      if (docs.isNotEmpty) {
        DocumentSnapshot teamDoc = docs[0];
        Map<String, dynamic> teamData = teamDoc.data() as Map<String, dynamic>;
        String teamId = teamDoc.id;

        QuerySnapshot employeesSnapshot = await FirebaseFirestore.instance
            .collection('employees')
            .where('teamId', isEqualTo: teamId)
            .get();

        List<QueryDocumentSnapshot> employeesDocs = employeesSnapshot.docs;

        List<Employee> employees = employeesDocs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Employee(
            id: doc.id,
            teamId: data['teamId'],
            name: data['name'],
            advance: data['advance'],
            hours: data['hours'],
            image: data['image'],
            percent: data['percent'].toDouble(),
            totalTips: data['totalTips'],
          );
        }).toList();
        QuerySnapshot currenciesSnapshot = await FirebaseFirestore.instance
            .collection('currencies')
            .where('teamId', isEqualTo: teamId)
            .get();
        List<QueryDocumentSnapshot> currenciesDocs = currenciesSnapshot.docs;
        List<Currency> currenices = currenciesDocs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Currency(
            id: doc.id,
            teamId: data['teamId'],
            name: data['name'],
            amount: data['amount'],
            rate: data['rate'],
          );
        }).toList();
        var team = Team(
          id: teamId,
          name: teamData['name'],
          adminId: teamData['adminId'],
          mainCurrencyName: teamData['mainCurrencyName'],
          mainCurrencySum: teamData['mainCurrencySum'],
          currencies: currenices,
          employees: employees,
        );
        team.countEmployeesMoney();
        setTeam(team);
        yield team;
      } else {
        state = null;
        yield null;
      }
    } catch (e) {
      state = null;
      yield null;
    }
  }

  void setTeam(Team team) {
    state = team;
  }

  String? get teamId => state?.id;

  Future<void> addEmployee(String name) async {
    if (state?.id != null) {
      try {
        DocumentReference docRef =
            await FirebaseFirestore.instance.collection('employees').add({
          'teamId': state!.id,
          'name': name,
          'advance': 0,
          'hours': 0,
          'image': '',
          'percent': 1.0,
          'totalTips': 0,
        });

        String newEmployeeId = docRef.id;

        Employee newEmployee = Employee(
          id: newEmployeeId,
          teamId: state!.id!,
          name: name,
          advance: 0,
          hours: 0,
          image: '',
          percent: 1.0,
          totalTips: 0,
        );

        var newState = Team(
          id: state!.id,
          name: state!.name,
          adminId: state!.adminId,
          mainCurrencyName: state!.mainCurrencyName,
          mainCurrencySum: state!.mainCurrencySum,
          currencies: List.from(state!.currencies),
          employees: List.from(state!.employees)..add(newEmployee),
        );

        state = newState;
      } catch (e) {
        print('Error adding employee: $e');
      }
    }
  }

  Future<void> addCurrency(String name, int? rate) async {
    if (state?.id != null) {
      final currencyRate = rate ?? 100;
      try {
        DocumentReference docRef =
            await FirebaseFirestore.instance.collection('currencies').add({
          'teamId': state!.id,
          'name': name,
          'rate': currencyRate,
          'amount': 0,
        });

        String newCurrencyId = docRef.id;

        Currency newCurrency = Currency(
            teamId: state!.id,
            name: name,
            rate: currencyRate,
            amount: 0,
            id: newCurrencyId);

        var newState = Team(
          id: state!.id,
          name: state!.name,
          adminId: state!.adminId,
          mainCurrencyName: state!.mainCurrencyName,
          mainCurrencySum: state!.mainCurrencySum,
          currencies: List.from(state!.currencies)..add(newCurrency),
          employees: List.from(state!.employees),
        );

        state = newState;
      } catch (e) {
        print('Error adding employee: $e');
      }
    }
  }

  Future<void> removeCurrency(String id) async {
    if (state?.id != null) {
      try {
        await FirebaseFirestore.instance
            .collection('currencies')
            .doc(id)
            .delete();
        var updatedCurrencies = List<Currency>.from(state!.currencies)
          ..removeWhere((currency) => currency.id == id);

        var newState = Team(
          id: state!.id,
          name: state!.name,
          adminId: state!.adminId,
          mainCurrencyName: state!.mainCurrencyName,
          mainCurrencySum: state!.mainCurrencySum,
          currencies: updatedCurrencies,
          employees: List.from(state!.employees),
        );

        state = newState;
      } catch (e) {
        print('Error removing currency: $e');
      }
    }
  }

  Employee? getEmployeeById(String id) {
    if (state != null) {
      return state!.employees.firstWhereOrNull((employee) => employee.id == id);
    }
    return null;
  }

  Future<void> addMoney(Map<String, int> moneyData) async {
    try {
      int mainCurrencySum = state!.mainCurrencySum;
      var newState = Team(
        id: state!.id,
        name: state!.name,
        adminId: state!.adminId,
        mainCurrencyName: state!.mainCurrencyName,
        mainCurrencySum: state!.mainCurrencySum,
        currencies: List.from(state!.currencies),
        employees: List.from(state!.employees),
      );

      if (moneyData.containsKey(newState.mainCurrencyName)) {
        mainCurrencySum += moneyData[newState.mainCurrencyName]!;
        await FirebaseFirestore.instance
            .collection('teams')
            .doc(state!.id)
            .update({
          'mainCurrencySum': mainCurrencySum,
        });
        newState.mainCurrencySum = mainCurrencySum;
      }
      for (var entry in moneyData.entries) {
        var currencyId = entry.key;
        var amountToAdd = entry.value;
        if (newState.currencies.isNotEmpty) {
          var currency =
              newState.currencies.firstWhereOrNull((c) => c.id == currencyId);
          if (currency != null && currency.id == currencyId) {
            currency.amount += amountToAdd;
            await FirebaseFirestore.instance
                .collection('currencies')
                .doc(currency.id)
                .update({
              'amount': currency.amount,
            });
          }
        }
      }
      newState.countEmployeesMoney();
      state = newState;
    } catch (error) {
      print(error);
    }
  }

  Future<void> setMoney(Map<String, int> moneyData) async {
    try {
      int mainCurrencySum = state!.mainCurrencySum;
      var newState = Team(
        id: state!.id,
        name: state!.name,
        adminId: state!.adminId,
        mainCurrencyName: state!.mainCurrencyName,
        mainCurrencySum: state!.mainCurrencySum,
        currencies: List.from(state!.currencies),
        employees: List.from(state!.employees),
      );

      if (moneyData.containsKey(newState.mainCurrencyName)) {
        mainCurrencySum = moneyData[newState.mainCurrencyName]!;
        await FirebaseFirestore.instance
            .collection('teams')
            .doc(state!.id)
            .update({
          'mainCurrencySum': mainCurrencySum,
        });
        newState.mainCurrencySum = mainCurrencySum;
      }
      for (var entry in moneyData.entries) {
        var currencyId = entry.key;
        var amountToAdd = entry.value;
        if (newState.currencies.isNotEmpty) {
          var currency = newState.currencies.firstWhereOrNull(
            (c) => c.id == currencyId,
          );
          print(currency);
          if (currency != null && currency.id == currencyId) {
            currency.amount = amountToAdd;
            await FirebaseFirestore.instance
                .collection('currencies')
                .doc(currency.id)
                .update({
              'amount': currency.amount,
            });
          }
        }
      }
      newState.countEmployeesMoney();
      state = newState;
    } catch (error) {
      print(error);
    }
  }

  int getTeamTotalSum() {
    if (state == null) {
      return 0;
    }
    int result = state!.mainCurrencySum;
    for (final currency in state!.currencies) {
      result += currency.rate * currency.amount;
    }
    return result;
  }

  Future<void> resetHours(int hours) async {
    for (final Employee employee in state!.employees) {
      try {
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(employee.id)
            .update({
          'hours': hours,
        });
        var newState = Team(
          id: state!.id,
          name: state!.name,
          adminId: state!.adminId,
          mainCurrencyName: state!.mainCurrencyName,
          mainCurrencySum: 0,
          currencies: List.from(state!.currencies),
          employees: state!.employees.map((employee) {
            return Employee(
              id: employee.id,
              teamId: employee.teamId,
              name: employee.name,
              hours: hours,
              advance: employee.advance,
              image: employee.image,
              percent: employee.percent,
              totalTips:
                  employee.totalTips, // Ensure totalTips remains unchanged
            );
          }).toList(),
        );
        state = newState;
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> resetTeamMoney() async {
    for (final Employee employee in state!.employees) {
      if (employee.totalTips < 0) {
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(employee.id)
            .update({
          'hours': 0,
          'advance': -employee.totalTips,
        });
      }
    }
    if (state!.currencies.isNotEmpty) {
      for (final currency in state!.currencies) {
        await FirebaseFirestore.instance
            .collection('currencies')
            .doc(currency.id)
            .update({
          'amount': 0,
        });
      }
    }
    await FirebaseFirestore.instance.collection('teams').doc(state!.id).update({
      'mainCurrencySum': 0,
    });
    var newState = Team(
      id: state!.id,
      name: state!.name,
      adminId: state!.adminId,
      mainCurrencyName: state!.mainCurrencyName,
      mainCurrencySum: 0,
      currencies: List.from(state!.currencies),
      employees: state!.employees.map((employee) {
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

  Future<void> setEmployeeData(String id, EmployeeData data) async {
    try {
      // Update Firestore document
      await FirebaseFirestore.instance.collection('employees').doc(id).update({
        'hours': data.hours,
        'advance': data.advance,
      });
      var newState = Team(
        id: state!.id,
        name: state!.name,
        adminId: state!.adminId,
        mainCurrencyName: state!.mainCurrencyName,
        mainCurrencySum: state!.mainCurrencySum,
        currencies: List.from(state!.currencies),
        employees: state!.employees.map((employee) {
          if (employee.id == id) {
            return Employee(
              id: employee.id,
              teamId: employee.teamId,
              name: employee.name,
              hours: data.hours,
              advance: data.advance,
              image: employee.image,
              percent: employee.percent,
              totalTips: employee.totalTips,
            );
          }
          return employee;
        }).toList(),
      );
      newState.countEmployeesMoney();
      state = newState;
    } catch (e) {
      print('Error updating employee data: $e');
    }
  }

  void clearTeam() {
    state = null;
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, Team?>((ref) {
  return TeamNotifier();
});
