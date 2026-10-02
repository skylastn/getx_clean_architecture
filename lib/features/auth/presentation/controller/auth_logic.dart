import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/model/response/cabang/sub_cabang_user_response.dart';
import '../../domain/model/response/user/user_response.dart';
import '../../application/auth_service.dart';
import '../../application/user_service.dart';
import '../../../../shared/core/presentation/logic/shared_preferences_logic.dart';
import '../login/login_page.dart';

class AuthLogic extends GetxController {
  var user = Rxn<UserResponse>();
  var subCabangUser = Rxn<SubCabangUserResponse>();
  final AuthService _authService = AuthService();
  final UserService service = UserService();
  final localDb = Get.find<SharedPreferencesLogic>();
  RxBool isLoading = false.obs;
  final ImagePicker picker = ImagePicker();
  Rxn<XFile> profilImage = Rxn<XFile>();

  Future<void> fetchUser({bool isRefresh = false}) async {
    try {
      final newUser = await service.fetchMe();

      user.value = newUser;
      if (isRefresh) user.refresh();

      final newList = newUser?.subCabangUser ?? [];

      if (newList.isEmpty) {
        subCabangUser.value = null;
        return;
      }

      if (localDb.subCabangUser != null && subCabangUser.value == null) {
        subCabangUser.value = localDb.subCabangUser;
        return;
      }
      if (localDb.subCabangUser == null &&
          subCabangUser.value == null &&
          newList.isNotEmpty) {
        changeSubCabangUser(subCabangUser: newList.first);
        return;
      }

      // 🧠 Cek apakah subCabangUser lama masih valid di list baru
      if (subCabangUser.value != null) {
        final matched = newList.firstWhere(
          (e) => e.id == subCabangUser.value?.id,
          orElse: () => newList.first,
        );
        // ambil instance dari list baru (bukan dari yang lama)
        subCabangUser.value = matched;
      } else {
        // kalau belum pernah pilih, pakai default dari list baru
        subCabangUser.value = newList.first;
      }
    } catch (e) {
      Get.log('Error fetching user: $e');
    }
  }

  void changeSubCabangUser({SubCabangUserResponse? subCabangUser}) {
    this.subCabangUser.value = subCabangUser;
    localDb.saveSubCabangUser(subCabangUser);
  }

  Future<void> changePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'New Password and Confirm Password do not match');
      return;
    }

    isLoading.value = true;
    bool success = await _authService.changePassword(
      oldPassword,
      newPassword,
      confirmPassword,
    );

    if (success) {
      Get.snackbar('Success', 'Password changed successfully');
    } else {
      Get.snackbar('Error', 'Failed to change password');
    }

    isLoading.value = false;
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Set timeout untuk request
      await _authService.logout().timeout(const Duration(seconds: 5),
          onTimeout: () {
        Get.log('Request timeout, langsung hapus token');
        Get.find<SharedPreferencesLogic>().removeTokenPOS();
        return Get.find<SharedPreferencesLogic>()
            .removeToken()
            .then((_) => true);
      });

      user.value = null;
      Get.offAllNamed(LoginPage.routeName);
    } catch (e) {
      Get.log('Error during logout: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void imageChoice() async {
    profilImage.value = await picker.pickImage(source: ImageSource.gallery);
    updateProfile(user.value?.name ?? '', user.value?.phone ?? '');
  }

  Future<void> updateProfile(String name, String phone) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      if (user.value?.id == null) throw Exception('User ID is null');
      await _authService.updateUserProfile(
        id: user.value!.id!,
        name: name,
        phone: phone,
        image: profilImage.value,
      );
      await fetchUser(isRefresh: true);
      profilImage.value = null;
    } catch (e) {
      Get.log('Error during update profile: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }
}
