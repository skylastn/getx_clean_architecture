import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/model/user_model.dart';
import '../domain/interface/auth_repository_base.dart';
import '../domain/model/response/user/user_response.dart';

class AuthService {
  AuthService({AuthRepositoryBase? repository})
      : _repository = repository ?? Get.find<AuthRepositoryBase>();

  final AuthRepositoryBase _repository;

  Future<Either<String, UserResponse?>> register({
    required String name,
    required String email,
    required String password,
    required String cPassword,
    required String phone,
    required String subCabangCode,
    required String repositoryCode,
  }) =>
      _repository.register(
        name: name,
        email: email,
        password: password,
        cPassword: cPassword,
        phone: phone,
        subCabangCode: subCabangCode,
        repositoryCode: repositoryCode,
      );

  Future<Either<String, UserResponse?>> login(
          String username, String password) =>
      _repository.login(username, password);

  Future<String?> loginPOS(String username, String password) =>
      _repository.loginPOS(username, password);

  Future<Map<String, dynamic>> verifyEmail(
          String email, String verificationCode) =>
      _repository.verifyEmail(email, verificationCode);

  Future<UserModel> updateUserProfile({
    required int id,
    required String name,
    required String phone,
    XFile? image,
  }) =>
      _repository.updateUserProfile(
          id: id, name: name, phone: phone, image: image);

  Future<bool> changePassword(
          String currentPassword, String newPassword, String confirmPassword) =>
      _repository.changePassword(currentPassword, newPassword, confirmPassword);

  Future<bool> logout() => _repository.logout();
}
