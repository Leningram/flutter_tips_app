import 'package:flutter_tips_app/data/models/team.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Employee {
  String id;
  final String teamId;
  final String name;
  int advance;
  int _hours;
  final String image;
  final double percent;
  int totalTips;
  Team? team;

  Employee({
    required this.teamId,
    required this.name,
    required this.advance,
    required int hours,
    required this.image,
    required this.percent,
    required this.totalTips,
    this.team,
    String? id,
  })  : id = id ?? uuid.v4(),
        _hours = hours;

  int get hours => _hours;

  int getTotalTips() {
    return totalTips;
  }

  set hours(int value) {
    _hours = value;
    team?.countEmployeesMoney();
  }

  void setTotalTips(int perHour) {
    totalTips = ((_hours * perHour - advance).floor() ~/ 10) * 10;
  }
}
