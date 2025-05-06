import 'package:flutter/material.dart';
import 'package:sample_app/features/core/application/komik_service.dart';
import 'package:get/get.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  HomeState state = HomeState();

  @override
  void onReady() {
    getPopularKomik();
    super.onReady();
  }

  Future<void> getPopularKomik() async {
    var response = await KomikService().getPopularKomik();
    response.fold((l) => Get.log(l.message), (r) {
      state.listPopularKomik.assignAll(r.datas ?? []);
      update();
    });
  }

  void showProduct() {
    // isShowProduct = true;
    // update();
  }

  IconData getIcon(TabType tab) {
    if (tab == TabType.home) {
      return Icons.home;
    }
    if (tab == TabType.genre) {
      return Icons.panorama_wide_angle_select_outlined;
    }
    if (tab == TabType.library) {
      return Icons.my_library_books_sharp;
    }
    if (tab == TabType.me) {
      return Icons.account_circle_sharp;
    }
    return Icons.search;
  }
}
