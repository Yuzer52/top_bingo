class PlayerRecord {
  final int cartela;

  PlayerRecord({required this.cartela});

  Map<String, dynamic> toJson() => {
        'cartela': cartela,
      };

  factory PlayerRecord.fromJson(Map<String, dynamic> json) => PlayerRecord(
        cartela: json['cartela'],
      );
}
