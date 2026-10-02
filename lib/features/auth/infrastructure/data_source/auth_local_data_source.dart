import '../../../../shared/core/presentation/logic/shared_preferences_logic.dart';
import '../../domain/model/response/user/user_response.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this._storage);

  final SharedPreferencesLogic _storage;

  Future<void> saveLogin(
      UserResponse user, String token, String password) async {
    await _storage.saveToken(token);
    await _storage.saveUserId(user.id ?? 0);
    await _storage.saveUsername(user.name ?? '');
    await _storage.savePassword(password);
    await _storage.saveEmail(user.email as String);
  }

  Future<void> saveTokenPOS(String token) => _storage.saveTokenPOS(token);

  Future<void> clearSession() => _storage.clearSession();
}
