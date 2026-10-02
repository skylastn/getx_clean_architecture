import 'dart:convert';

import '../../../../shared/core/network/api_provider.dart';
import '../../domain/model/response/user/user_response.dart';

class UserRemoteDataSource {
  UserRemoteDataSource(this._provider);

  final ApiProvider _provider;

  Future<UserResponse?> fetchMe() async {
    final response = await _provider.get('user/me');
    final json = jsonDecode(response.result?.body ?? '');
    if (response.isError) return null;
    return UserResponse.fromMap(json['data']);
  }
}
