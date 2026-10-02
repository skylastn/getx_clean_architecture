import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../domain/model/user_model.dart';
import '../../../../shared/core/network/api_provider.dart';
import '../../domain/model/response/user/user_response.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._provider, this._providerPOS);

  final ApiProvider _provider;
  final ApiProvider _providerPOS;

  Future<Either<String, UserResponse?>> register({
    required String name,
    required String email,
    required String password,
    required String cPassword,
    required String phone,
    required String subCabangCode,
    required String repositoryCode,
  }) async {
    try {
      final response = await _provider.post('register', body: {
        'name': name,
        'email': email,
        'phone': phone,
        'sub_cabang_code': subCabangCode,
        'repository_code': repositoryCode,
        'password': password,
        'c_password': cPassword,
      });
      if (response.isError) return Left(response.msg);
      final Map<String, dynamic> body = jsonDecode(response.result?.body ?? '');
      if (body['message'] ==
          'User Created Successfully, please verify your email') {
        return Left(body['message']);
      }
      // Preserve the original response validation; registration never saves it.
      body['data']['token'] as String;
      return Right(UserResponse.fromMap(body));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ({UserResponse user, String token})>> login(
      String username, String password) async {
    final response = await _provider.post('login', body: {
      'username': username,
      'password': password,
    });
    if (response.isError) return Left(response.msg);
    final Map<String, dynamic> body = jsonDecode(response.result?.body ?? '');
    final user = UserResponse.fromMap(body['data']['user']);
    final String token = body['data']['token'];
    return Right((user: user, token: token));
  }

  Future<String?> loginPOS(String username, String password) async {
    final response = await _providerPOS.post('user/authenticate', body: {
      'email': username,
      'password': password,
    });
    if (response.isError) return null;
    final Map<String, dynamic> body = jsonDecode(response.result?.body ?? '');
    if (body['status'] == false) return null;
    return body['data']['access_token'] as String;
  }

  Future<Map<String, dynamic>> verifyEmail(
      String email, String verificationCode) async {
    final response = await _provider.post('verify', body: {
      'email': email,
      'verification_code': verificationCode,
    });
    if (response.isError) return {'status': false, 'message': response.msg};
    final Map<String, dynamic> body = jsonDecode(response.result?.body ?? '');
    return body;
  }

  Future<UserModel> updateUserProfile({
    required int id,
    required String name,
    required String phone,
    XFile? image,
  }) async {
    final files = <http.MultipartFile>[];
    if (image != null) {
      final mime = lookupMimeType(image.path)?.split('/');
      files.add(http.MultipartFile.fromBytes(
        'image',
        await image.readAsBytes(),
        filename: image.path,
        contentType: mime != null
            ? MediaType(mime[0], mime[1])
            : MediaType('image', 'jpeg'),
      ));
    }
    final response = await _provider.uploadImage('user/update/$id',
        fields: {'name': name, 'phone': phone}, files: files);
    if (response.isError) throw Exception(response.msg);
    final Map<String, dynamic> body = jsonDecode(response.result?.body ?? '');
    return UserModel.fromJson(body['data']);
  }

  Future<bool> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    final response = await _provider.post('user/changePassword', body: {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    });
    if (response.isError) return false;
    final Map<String, dynamic> body = jsonDecode(response.result?.body ?? '');
    return body['status'] == true;
  }

  Future<bool> logout() async {
    final response = await _provider.post('logout');
    return !response.isError;
  }
}
