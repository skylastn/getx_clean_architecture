import 'dart:convert';

import '../../domain/model/forgot_password_model.dart';
import '../../../../shared/core/network/api_provider.dart';

class ForgotPasswordRemoteDataSource {
  ForgotPasswordRemoteDataSource(this._provider);

  final ApiProvider _provider;

  Future<ForgotPasswordModel?> sendOtp(String email) =>
      _post('forget', {'email': email});

  Future<ForgotPasswordModel?> verifyOtp(
          String email, String verificationCode) =>
      _post('verify/forget', {
        'email': email,
        'verification_code': verificationCode,
      });

  Future<ForgotPasswordModel?> changePassword(String email, String password) =>
      _post('change', {
        'email': email,
        'password': password,
        'c_password': password,
      });

  Future<ForgotPasswordModel?> _post(
      String endpoint, Map<String, String> body) async {
    try {
      final response = await _provider.post(endpoint, body: body);
      if (!response.isError && response.result != null) {
        return ForgotPasswordModel.fromJson(jsonDecode(response.result!.body));
      }
      return ForgotPasswordModel(
        status: false,
        code: response.result?.statusCode ?? 400,
        message: response.msg,
        email: '',
      );
    } catch (_) {
      return null;
    }
  }
}
