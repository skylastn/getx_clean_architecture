import 'package:get/get.dart';
import '../../features/auth/domain/interface/auth_repository_base.dart';
import '../../features/auth/domain/interface/forgot_password_repository_base.dart';
import '../../features/auth/domain/interface/user_repository_base.dart';
import '../../features/auth/infrastructure/data_source/auth_local_data_source.dart';
import '../../features/auth/infrastructure/data_source/auth_remote_data_source.dart';
import '../../features/auth/infrastructure/data_source/forgot_password_remote_data_source.dart';
import '../../features/auth/infrastructure/data_source/user_remote_data_source.dart';
import '../../features/auth/infrastructure/repository/auth_repository.dart';
import '../../features/auth/infrastructure/repository/forgot_password_repository.dart';
import '../../features/auth/infrastructure/repository/user_repository.dart';
import 'presentation/logic/auth_logic.dart';
import '../config/app_config.dart';
import 'network/api_provider.dart';
import 'presentation/logic/global_logic.dart';
import 'presentation/logic/shared_preferences_logic.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    try {
      final localCtrl = Get.put(SharedPreferencesLogic(), permanent: true);
      await localCtrl.init();

      final membership = Get.put(ApiProvider(baseUrl: AppConfig.baseUrl));
      final pos = Get.put(
        ApiProvider(baseUrl: AppConfig.posBaseUrl),
        tag: ProviderType.pos.name,
      );

      Get.lazyPut<AuthRepositoryBase>(
        () => AuthRepository(
          AuthRemoteDataSource(membership, pos),
          AuthLocalDataSource(localCtrl),
        ),
        fenix: true,
      );
      Get.lazyPut<UserRepositoryBase>(
        () => UserRepository(UserRemoteDataSource(membership)),
        fenix: true,
      );
      Get.lazyPut<ForgotPasswordRepositoryBase>(
        () => ForgotPasswordRepository(
          ForgotPasswordRemoteDataSource(membership),
        ),
        fenix: true,
      );

      Get.put(AuthLogic(), permanent: true);
      Get.put(GlobalLogic(), permanent: true);
    } catch (e) {
      Get.log('error Init Dependency $e');
    }
  }
}
