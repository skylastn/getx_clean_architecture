import 'package:get/get.dart';

import '../domain/model/forgot_password_model.dart';
import '../domain/interface/forgot_password_repository_base.dart';

class ForgotPasswordService {
  ForgotPasswordService({ForgotPasswordRepositoryBase? repository})
      : _repository = repository ?? Get.find<ForgotPasswordRepositoryBase>();

  final ForgotPasswordRepositoryBase _repository;

  Future<ForgotPasswordModel?> sendOtp(String email) =>
      _repository.sendOtp(email);

  Future<ForgotPasswordModel?> verifyOtp(
          String email, String verificationCode) =>
      _repository.verifyOtp(email, verificationCode);

  Future<ForgotPasswordModel?> changePassword(String email, String password) =>
      _repository.changePassword(email, password);
}
