import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPreferencesService {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  Future<SharedPreferences> get preferences async => await _preferences;

  Future<void> storeCredentials(String token) async {
    var preferences = await _preferences;
    await preferences.setString('token', token);
  }

  Future<String> getToken() async {
    var preferences = await _preferences;
    return await preferences.getString('token');
  }

  Future<void> storeToken(String token) async {
    var preferences = await _preferences;
    await preferences.setString('token', token);
  }
}
