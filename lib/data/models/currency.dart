import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Currency {
  String id;
  final int teamId;
  final String name;
  final int rate;
  int amount;

  Currency({
    String? id,
    required this.teamId,
    required this.name,
    required this.rate,
    required this.amount,
  }) : id = id ?? uuid.v4();
}
