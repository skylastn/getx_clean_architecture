// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../../features/auth/presentation/forgot/password/forgot_password_binding.dart';
import '../../features/auth/presentation/forgot/password/forgot_password_page.dart';
import '../../features/auth/presentation/forgot/password/otp_forgot_password/otp_forgot_password_binding.dart';
import '../../features/auth/presentation/forgot/password/otp_forgot_password/otp_forgot_password_page.dart';
import '../../features/auth/presentation/login/login_binding.dart';
import '../../features/auth/presentation/login/login_page.dart';
import '../../features/auth/presentation/new_password/new_password_binding.dart';
import '../../features/auth/presentation/new_password/new_password_page.dart';
import '../../features/auth/presentation/register/register_binding.dart';
import '../../features/auth/presentation/register/register_page.dart';
import '../../features/auth/presentation/splash/splash_binding.dart';
import '../../features/auth/presentation/splash/splash_page.dart';
import '../../features/auth/presentation/verify/otp/verify_otp_binding.dart';
import '../../features/auth/presentation/verify/otp/verify_otp_page.dart';
import '../../features/core/presentation/homepage/home_binding.dart';
import '../../features/core/presentation/homepage/home_ui.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.OTP_FORGOT_PASSWORD,
      page: () => OtpForgotPasswordPage(),
      binding: OtpForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.NEW_PASSWORD,
      page: () => NewPasswordPage(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_OTP,
      page: () => VerifyOtpPage(),
      binding: VerifyOtpBinding(),
    ),
  ];
}
