import 'package:shared_preferences/shared_preferences.dart';
import 'i_auth_local_datasource.dart';

class AuthLocalDataSource implements IAuthLocalDataSource {
  final SharedPreferences _prefs;
  AuthLocalDataSource(this._prefs);

  @override
  Future<void> cacheUserEmail(String email) async {
    await _prefs.setString('email', email);
  }

  @override
  String? getCachedUserEmail() {
    return _prefs.getString('email');
  }

  @override
  Future<void> clearCachedUser() async {
    await _prefs.remove('email');
  }
}
