import 'package:flutter_tips_app/data/models/team.dart';

class Employee {
  final String name;
  final int advance;
  final int hours;
  final String image;
  final double percent;
  Team? team;

  Employee({
    required this.name,
    required this.advance,
    required this.hours,
    required this.image,
    required this.percent,
    this.team,
  });

  int calculateEarnings() {
    if (team == null) return 0;
    int teamTotal = team!.getTeamTotal();
    int totalHours = team!.getTotalHours();
    if (totalHours == 0) return 0; // Чтобы избежать деления на ноль
    double hourlyRate = teamTotal / totalHours;
    return (hours * hourlyRate).round();
  }
}
