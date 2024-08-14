class UserGameModel {
  String? id;
  String? userId;
  String? gameId;
  String? status;
  int? yapilansure;
  int? toplamSure;
  double? dogruSayisi;
  double? denemeSayisi;
  double? ipucuSayisi;
  List<Map<String, dynamic>>? sorular;

  UserGameModel({
    required this.id,
    required this.userId,
    required this.gameId,
    required this.status,
    required this.yapilansure,
    required this.toplamSure,
    required this.dogruSayisi,
    required this.denemeSayisi,
    required this.ipucuSayisi,
    required this.sorular,
  });

  UserGameModel.empty() {
    id = '';
    userId = '';
    gameId = '';
    status = '';
    yapilansure = 0;
    toplamSure = 0;
    dogruSayisi = 0;
    denemeSayisi = 0;
    ipucuSayisi = 0;
    sorular = [];
  }

  factory UserGameModel.fromJson(Map<String, dynamic> json) {
    return UserGameModel(
      id: json['id'],
      userId: json['userId'],
      gameId: json['gameId'],
      status: json['status'],
      yapilansure: json['yapilansure'],
      toplamSure: json['toplamSure'],
      dogruSayisi: json['dogruSayisi'],
      denemeSayisi: json['denemeSayisi'],
      ipucuSayisi: json['ipucuSayisi'],
      sorular: (json['sorular'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'gameId': gameId,
      'status': status,
      'yapilansure': yapilansure,
      'toplamSure': toplamSure,
      'dogruSayisi': dogruSayisi,
      'denemeSayisi': denemeSayisi,
      'ipucuSayisi': ipucuSayisi,
      'sorular': sorular?.map((e) => e).toList(),
    };
  }
}
