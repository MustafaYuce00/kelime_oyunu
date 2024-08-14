import 'package:kelime_oyunu/model/userGame.dart';

class UserModel {
  String? id;
  String? name;
  String? image;
  String? role;
  String? status;
  DateTime? lastLogin;
  DateTime? lastLogout;
  DateTime? lastActivity;
  List<UserGameModel>? kullaniciOyunlari;

  UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.role,
    required this.status,
    required this.lastLogin,
    required this.lastLogout,
    required this.lastActivity,
    required this.kullaniciOyunlari,
  });

  UserModel.empty(){
    id = '';
    name = '';
    image = '';
    role = '';
    status = '';
    lastLogin = DateTime.now();
    lastLogout = DateTime.now();
    lastActivity = DateTime.now();
    kullaniciOyunlari = [];
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    role = json['role'];
    status = json['status'];
    lastLogin = DateTime.parse(json['lastLogin']);
    lastLogout = DateTime.parse(json['lastLogout']);
    lastActivity = DateTime.parse(json['lastActivity']);
    if (json['kullaniciOyunlari'] != null) {
      kullaniciOyunlari = <UserGameModel>[];
      json['kullaniciOyunlari'].forEach((v) {
        kullaniciOyunlari!.add(UserGameModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['role'] = role;
    data['status'] = status;
    data['lastLogin'] = lastLogin!.toIso8601String();
    data['lastLogout'] = lastLogout!.toIso8601String();
    data['lastActivity'] = lastActivity!.toIso8601String();
    if (kullaniciOyunlari != null) {
      data['kullaniciOyunlari'] =
          kullaniciOyunlari!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
