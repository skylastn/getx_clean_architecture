import 'package:flutter/material.dart';

import 'app_store_application.dart';

class AppProvider extends InheritedWidget {
  final AppStoreApplication application;

  const AppProvider(
      {super.key, required super.child, required this.application});

  @override
  bool updateShouldNotify(oldWidget) => true;

  static AppProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>()
        as AppProvider);
  }

  static AppStoreApplication getApplication(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>()
            as AppProvider)
        .application;
  }
}
