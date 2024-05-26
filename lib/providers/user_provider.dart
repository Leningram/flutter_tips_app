import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

final Employee userDefaultData = Employee(
  name: '',
  team: '',
  tipsAmount: 0,
  advance: 0,
  hours: 0,
  image: '',
  percent: 0.0,
);

class UserNotifier extends StateNotifier<Employee?> {
  UserNotifier(this.ref) : super(userDefaultData);

  final Ref ref;

  void setUserById(String name) {
    final team = ref.read(teamProvider);
    state = team.firstWhereOrNull((employee) => employee.name == name);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, Employee?>((ref) {
  return UserNotifier(ref);
});