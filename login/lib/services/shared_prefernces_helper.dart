import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // هذا السطر بيخلي كل ما اسوي نسخة من نفس الكائن راح يعتبر مكان واحد
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  late SharedPreferences _prefs;

  SharedPrefsHelper._internal();
// هو اللي بيصنع النسخه حقت الشيريد بريفرينس 
  factory SharedPrefsHelper() => _instance;


// لما انادي على هذي الداله يعطي قيمة للمتغير اللي اسمه 
//_prefs ويخليها تساوي نسخة من الشيرد بريفرانيس 
// future عشان نناديها برا
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

// علامة الاستفهام تقول لفلاتر ان هذي الداله ممكن ترجع سترنق او نل
// بعطيها مفتاح وتعطيني القيمة 
  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);


  Future<void> clear() => _prefs.clear();
}

