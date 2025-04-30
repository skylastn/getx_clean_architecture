// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../features/core/presentation/homepage/home_binding.dart';
import '../features/core/presentation/homepage/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
