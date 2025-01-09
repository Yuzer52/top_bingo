class GameRecord {
  String name;
  String date;
  List<int> calledNumbers;
  int playerCount;
  double pay;
  double winnings;
  bool wonWithLuckyNumber;
  int? bonusAmount;

  GameRecord({
    required this.name,
    required this.date,
    required this.calledNumbers,
    required this.playerCount,
    required this.pay,
    required this.winnings,
    this.wonWithLuckyNumber = false,
    this.bonusAmount,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date,
    'calledNumbers': calledNumbers,
    'playerCount': playerCount,
    'pay': pay,
    'winnings': winnings,
    'wonWithLuckyNumber': wonWithLuckyNumber,
    'bonusAmount': bonusAmount,
  };

  factory GameRecord.fromJson(Map<String, dynamic> json) => GameRecord(
    name: json['name'],
    date: json['date'],
    calledNumbers: List<int>.from(json['calledNumbers']),
    playerCount: json['playerCount'],
    pay: json['pay'].toDouble(),
    winnings: json['winnings'].toDouble(),
    wonWithLuckyNumber: json['wonWithLuckyNumber'] ?? false,
    bonusAmount: json['bonusAmount'],
  );
}
