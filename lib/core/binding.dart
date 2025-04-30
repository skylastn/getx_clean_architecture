import 'package:get/get.dart';
import '../features/core/infrastructure/repository/komik_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomikRepository>(() => KomikRepository());
  }
  // @override
  // List<Bind> dependencies() {
  //   return [
  //     Bind.lazyPut<KomikRepository>(
  //       () => KomikRepository(),
  //     ),
  //   ];
  // }
}
