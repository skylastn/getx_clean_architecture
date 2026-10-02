import '../model/response/user/user_response.dart';

abstract class UserRepositoryBase {
  Future<UserResponse?> fetchMe();
}
