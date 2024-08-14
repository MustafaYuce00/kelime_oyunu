import 'package:kelime_oyunu/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefshelper {
  static Future<void> girisKarsilamaKaydet(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('karsilama', value);
  }

  static Future<String> girisKarsilamaGetir() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedNumber = prefs.getString('karsilama');
    if (storedNumber != null) {
      return storedNumber;
    } else {
      return "";
    }
  }

  // userSave
  static Future<void> userSave(UserModel value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', value.toJson().toString());
  }

  static Future<UserModel?> userGetir() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedNumber = prefs.getString('user');
    if (storedNumber != null) {
      return UserModel.fromJson(storedNumber as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
