import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_tips_app/data/models/currency.dart';
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
        setTeam(Team(
          id: teamId,
          name: teamData['name'],
          adminId: teamData['adminId'],
          mainCurrencyName: teamData['mainCurrencyName'],
          mainCurrencySum: teamData['mainCurrencySum'],
          currencies: [],
          employees: employees,
        ));
        yield Team(
          id: teamId,
          name: teamData['name'],
          adminId: teamData['adminId'],
          mainCurrencyName: teamData['mainCurrencyName'],
          mainCurrencySum: teamData['mainCurrencySum'],
          currencies: [], // Assuming currencies are not fetched in this example
          employees: employees,
        );
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

  Employee? getEmployeeById(String id) {
    if (state != null) {
      return state!.employees.firstWhereOrNull((employee) => employee.id == id);
    }
  }

  void addMoney(Map<String, int> moneyData) {
    // var newState = Team(
    //   id: state.id,
    //   name: state.name,
    //   admin: state.admin,
    //   mainCurrencyName: state.mainCurrencyName,
    //   mainCurrencySum: state.mainCurrencySum,
    //   currencies: List.from(state.currencies),
    //   employees: List.from(state.employees),
    // );

    // if (moneyData.containsKey(newState.mainCurrencyName)) {
    //   newState.mainCurrencySum += moneyData[newState.mainCurrencyName]!;
    // }

    // for (var entry in moneyData.entries) {
    //   var currencyName = entry.key;
    //   var amountToAdd = entry.value;

    //   var currency = newState.currencies.firstWhere(
    //     (c) => c.name == currencyName,
    //     orElse: () => Currency(
    //         teamId: newState.id, name: currencyName, rate: 1, amount: 0),
    //   );

    //   if (currency.name == currencyName) {
    //     currency.amount += amountToAdd;
    //   } else {
    //     newState.currencies
    //         .add(Currency(teamId: newState.id,  name: currencyName, rate: 1, amount: amountToAdd));
    //   }
    // }
    // newState.countEmployeesMoney();
    // state = newState;
  }

  void setMoney(Map<String, int> moneyData) {
    // var newState = Team(
    //   id: state.id,
    //   name: state.name,
    //   admin: state.admin,
    //   mainCurrencyName: state.mainCurrencyName,
    //   mainCurrencySum: 0,
    //   currencies: List.from(state.currencies),
    // );

    // if (moneyData.containsKey(newState.mainCurrencyName)) {
    //   newState.mainCurrencySum += moneyData[newState.mainCurrencyName]!;
    // }

    // for (var entry in moneyData.entries) {
    //   var currencyName = entry.key;
    //   var amountToAdd = entry.value;

    //   var currency = newState.currencies.firstWhere(
    //     (c) => c.name == currencyName,
    //     orElse: () => Currency(teamId: newState.id, name: currencyName, rate: 1, amount: 0),
    //   );

    //   if (currency.name == currencyName) {
    //     currency.amount = amountToAdd;
    //   } else {
    //     newState.currencies
    //         .add(Currency(teamId: newState.id, name: currencyName, rate: 1, amount: amountToAdd));
    //   }
    // }
    // newState.countEmployeesMoney();
    // state = newState;
  }

  void resetTeamMoney() {
    // var newState = Team(
    //    id: state.id,
    //   name: state.name,
    //   admin: state.admin,
    //   mainCurrencyName: state.mainCurrencyName,
    //   mainCurrencySum: 0,
    //   currencies: List.from(state.currencies),
    //   employees: state.employees.map((employee) {
    //     if (employee.totalTips < 0) {
    //       // Make a copy of the employee object and update its data
    //       return Employee(
    //         id: employee.id,
    //         teamId: employee.teamId,
    //         name: employee.name,
    //         hours: employee.hours,
    //         advance: -employee.totalTips,
    //         image: employee.image,
    //         percent: employee.percent,
    //         totalTips: employee.totalTips, // Ensure totalTips remains unchanged
    //       );
    //     }
    //     return employee; // Return unmodified employee if name doesn't match
    //   }).toList(),
    // );

    // for (var currency in newState.currencies) {
    //   currency.amount = 0;
    // }
    // newState.countEmployeesMoney();
    // state = newState;
  }

  void setEmployeeData(String name, EmployeeData data) {
    // var newState = Team(
    //    id: state.id,
    //   name: state.name,
    //   admin: state.admin,
    //   mainCurrencyName: state.mainCurrencyName,
    //   mainCurrencySum: state.mainCurrencySum,
    //   currencies: List.from(state.currencies),
    //   employees: state.employees.map((employee) {
    //     if (employee.name == name) {
    //       // Make a copy of the employee object and update its data
    //       return Employee(
    //         id: employee.id,
    //         teamId: employee.teamId,
    //         name: employee.name,
    //         hours: data.hours,
    //         advance: data.advance,
    //         image: employee.image,
    //         percent: employee.percent,
    //         totalTips: employee.totalTips, // Ensure totalTips remains unchanged
    //       );
    //     }
    //     return employee; // Return unmodified employee if name doesn't match
    //   }).toList(),
    // );
    // newState.countEmployeesMoney(); // Recalculate employee money totals
    // state = newState; // Update the state with th
  }

  void clearTeam() {
    state = null;
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, Team?>((ref) {
  return TeamNotifier();
});
