import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user_model.dart';
import '../model/response/user/user_response.dart';

abstract class AuthRepositoryBase {
  Future<Either<String, UserResponse?>> register({
    required String name,
    required String email,
    required String password,
    required String cPassword,
    required String phone,
    required String subCabangCode,
    required String repositoryCode,
  });
  Future<Either<String, UserResponse?>> login(String username, String password);
  Future<String?> loginPOS(String username, String password);
  Future<Map<String, dynamic>> verifyEmail(
      String email, String verificationCode);
  Future<UserModel> updateUserProfile({
    required int id,
    required String name,
    required String phone,
    XFile? image,
  });
  Future<bool> changePassword(
      String currentPassword, String newPassword, String confirmPassword);
  Future<bool> logout();
}
