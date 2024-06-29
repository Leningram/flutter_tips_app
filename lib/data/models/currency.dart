
class Currency {
  String id;
  final String teamId;
  final String name;
  final int rate;
  int amount;

  Currency({
    required this.id,
    required this.teamId,
    required this.name,
    required this.rate,
    required this.amount,
  });
}
