# SkyKomik

Sample Flutter app showcasing **Clean Architecture + GetX** state management, with flavored
development / production environments.

## Tech stack

- Flutter 3.47 (stable) / Dart 3.13
- State management: [get](https://pub.dev/packages/get) 4.x
- Network: [http](https://pub.dev/packages/http), functional error handling via
  [dartz](https://pub.dev/packages/dartz)
- Local notifications: [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) 22.x
- Storage: [shared_preferences](https://pub.dev/packages/shared_preferences)
- Flavors: [flutter_flavorizr](https://pub.dev/packages/flutter_flavorizr)

## Requirements

| Tool | Version |
| ---- | ------- |
| Flutter | 3.47.x (stable) |
| Java | 17+ (project targets Java 21 bytecode) |
| Android Gradle Plugin | 9.1.0 |
| Gradle | 9.3.1 |
| Kotlin (KGP) | 2.4.0 |
| compileSdk / targetSdk | 36 (Play Store ready) |
| NDK | 28.2.13676358 |
| minSdk | 23 (Flutter default) |

## Getting started

```bash
flutter pub get
flutter run --flavor development -t lib/main_dev.dart
```

Production entrypoint: `lib/main_prod.dart`.

## Flavors

| Flavor | App ID | Entrypoint |
| ------ | ------ | ---------- |
| development | `id.my.skydemo.komik.dev` | `lib/main_dev.dart` |
| production | `id.my.skydemo.komik` | `lib/main_prod.dart` |

Regenerate platform flavor scaffolding after changing `flavorizr` in `pubspec.yaml`:

```bash
dart pub global activate flutter_flavorizr
flutter_flavorizr
```

## Useful commands

```bash
flutter analyze                        # must report "No issues found"
flutter build apk --flavor development --debug
flutter build appbundle --flavor production --release
```

## Project structure

```text
lib/
  main_dev.dart / main_prod.dart   flavor entrypoints (Env config)
  app/                             theme, network layer, global logic/models
  core/                            env bootstrap, DI, routes, session
  shared/                          local notifications, responsive shell widget,
                                   toast, device sizing, logging  (ponytail: extract
                                   to a shared package when a second app needs it)
  features/core/
    application/                   use-case services
    domain/                        repository contracts + request/response models
                                   (framework-free)
    infrastructure/                data sources (remote/local)
    presentation/                  GetX logic / state / views per page
```

## Notes

- Push notifications are local-only (`lib/shared/notif/`); no Firebase
  dependency remains in the app.
- Release signing lives in the gitignored `android/key.properties` — release
  builds need that file present locally.
