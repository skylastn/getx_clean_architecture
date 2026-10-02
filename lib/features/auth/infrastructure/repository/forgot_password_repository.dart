import '../../domain/model/forgot_password_model.dart';
import '../../domain/interface/forgot_password_repository_base.dart';
import '../data_source/forgot_password_remote_data_source.dart';

class ForgotPasswordRepository implements ForgotPasswordRepositoryBase {
  ForgotPasswordRepository(this._remoteDataSource);

  final ForgotPasswordRemoteDataSource _remoteDataSource;

  @override
  Future<ForgotPasswordModel?> sendOtp(String email) =>
      _remoteDataSource.sendOtp(email);

  @override
  Future<ForgotPasswordModel?> verifyOtp(
          String email, String verificationCode) =>
      _remoteDataSource.verifyOtp(email, verificationCode);

  @override
  Future<ForgotPasswordModel?> changePassword(String email, String password) =>
      _remoteDataSource.changePassword(email, password);
}
