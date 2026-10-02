import '../../domain/interface/user_repository_base.dart';
import '../../domain/model/response/user/user_response.dart';
import '../data_source/user_remote_data_source.dart';

class UserRepository implements UserRepositoryBase {
  UserRepository(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<UserResponse?> fetchMe() => _remoteDataSource.fetchMe();
}
