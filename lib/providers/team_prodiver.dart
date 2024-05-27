import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return state.employees.firstWhereOrNull((employee) => employee.name == name);
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, Team>((ref) {
  return TeamNotifier();
});
