import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/employee.dart';

class TeamNotifier extends StateNotifier<List<Employee>> {
  TeamNotifier() : super([]);

  void setTeam(List<Employee> team) {
    state = team;
  }

  Employee? getEmployeeById(String name) {
    return state.firstWhereOrNull((employee) => employee.name == name);
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, List<Employee>>((ref) {
  return TeamNotifier();
});
