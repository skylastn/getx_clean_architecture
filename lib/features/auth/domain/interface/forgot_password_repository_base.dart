import '../model/forgot_password_model.dart';

abstract class ForgotPasswordRepositoryBase {
  Future<ForgotPasswordModel?> sendOtp(String email);
  Future<ForgotPasswordModel?> verifyOtp(String email, String verificationCode);
  Future<ForgotPasswordModel?> changePassword(String email, String password);
}
