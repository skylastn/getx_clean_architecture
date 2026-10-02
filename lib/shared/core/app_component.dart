import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_pages.dart';
import 'app_provider.dart';
import 'app_store_application.dart';
import 'binding.dart';
import 'env.dart';

class AppComponent extends StatelessWidget {
  final AppStoreApplication _application;
  final String initialRoute;

  const AppComponent(this._application, this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    final myApp = GetMaterialApp(
      title: Env.value.appName,
      defaultTransition: Transition.cupertinoDialog,
      debugShowCheckedModeBanner: false,
      enableLog: kDebugMode,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      // binds: AppBinding.listInitialBinding,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
    final appProvider = AppProvider(application: _application, child: myApp);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: appProvider,
    );
  }
}
