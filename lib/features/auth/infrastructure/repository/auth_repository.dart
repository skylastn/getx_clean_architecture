import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/model/user_model.dart';
import '../../domain/interface/auth_repository_base.dart';
import '../../domain/model/response/user/user_response.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepository implements AuthRepositoryBase {
  AuthRepository(this._remoteDataSource, this._localDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Either<String, UserResponse?>> register({
    required String name,
    required String email,
    required String password,
    required String cPassword,
    required String phone,
    required String subCabangCode,
    required String repositoryCode,
  }) =>
      _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        cPassword: cPassword,
        phone: phone,
        subCabangCode: subCabangCode,
        repositoryCode: repositoryCode,
      );

  @override
  Future<Either<String, UserResponse?>> login(
      String username, String password) async {
    final result = await _remoteDataSource.login(username, password);
    return result.fold(
      (error) async => Left<String, UserResponse?>(error),
      (session) async {
        await _localDataSource.saveLogin(session.user, session.token, password);
        return Right<String, UserResponse?>(session.user);
      },
    );
  }

  @override
  Future<String?> loginPOS(String username, String password) async {
    final token = await _remoteDataSource.loginPOS(username, password);
    if (token != null) await _localDataSource.saveTokenPOS(token);
    return token;
  }

  @override
  Future<Map<String, dynamic>> verifyEmail(
          String email, String verificationCode) =>
      _remoteDataSource.verifyEmail(email, verificationCode);

  @override
  Future<UserModel> updateUserProfile({
    required int id,
    required String name,
    required String phone,
    XFile? image,
  }) =>
      _remoteDataSource.updateUserProfile(
          id: id, name: name, phone: phone, image: image);

  @override
  Future<bool> changePassword(
          String currentPassword, String newPassword, String confirmPassword) =>
      _remoteDataSource.changePassword(
          currentPassword, newPassword, confirmPassword);

  @override
  Future<bool> logout() async {
    final success = await _remoteDataSource.logout();
    if (success) await _localDataSource.clearSession();
    return success;
  }
}
