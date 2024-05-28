class Employee {
  final String name;
  final int advance;
  final int hours;
  final String image;
  final double percent;
  int totalTips;

  Employee({
    required this.name,
    required this.advance,
    required this.hours,
    required this.image,
    required this.percent,
    required this.totalTips,
  });

  int getTotalTips() {
    return totalTips;
  }

  void setTotalTips(int perHour) {
    totalTips = hours * perHour - advance;
  }
}
