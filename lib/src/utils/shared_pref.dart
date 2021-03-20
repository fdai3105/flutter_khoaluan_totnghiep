import '../resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static SharedPreferences _pref;

  static Future getInstance() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future setUser(User user) async {
    await _pref.setString('pref_user', user.toRawJson());
  }

  static User getUser() {
    final user = _pref.getString('pref_user');
    return User.fromRawJson(user);
  }

  static Future setToken(String token) async {
    final newUser = getUser()..copyWith(accessToken: token);
    await setUser(newUser);
  }

  static String getToken() {
    final user = getUser();
    return user.accessToken;
  }
}
