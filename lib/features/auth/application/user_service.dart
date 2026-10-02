import 'package:get/get.dart';

import '../domain/interface/user_repository_base.dart';
import '../domain/model/response/user/user_response.dart';

class UserService {
  UserService({UserRepositoryBase? repository})
      : _repository = repository ?? Get.find<UserRepositoryBase>();

  final UserRepositoryBase _repository;

  Future<UserResponse?> fetchMe() => _repository.fetchMe();
}
