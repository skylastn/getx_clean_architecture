# SkyKomik — Flutter Clean Architecture + GetX

[![Flutter](https://img.shields.io/badge/Flutter-3.47+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-teal)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![State](https://img.shields.io/badge/State-GetX%204.x-8A2BE2)](https://pub.dev/packages/get)
[![Android](https://img.shields.io/badge/Android%20API-36%20(Target%20%2F%20Compile)-34A853?logo=android&logoColor=white)](https://developer.android.com)

A production-ready Flutter template demonstrating **Clean Architecture** powered by **GetX** for reactive state management, compile-time environment configuration via `--dart-define`, Android Play Store readiness (SDK 36), and zero external tracking overhead.

---

## ⚡ Highlights

- **Clean Architecture Layers**: Strict separation between Domain, Infrastructure, Application, and Presentation.
- **GetX Pattern**: Separation of concerns using `Logic`, `State`, and `UI` (`GetView`).
- **Single Entrypoint**: Unified `lib/main.dart` configured via `--dart-define` or `.env`.
- **Play Store Ready**: Android SDK 36 (AGP 9.1.0, Gradle 9.3.1, Java 21, Kotlin 2.4.0).
- **Flavored Setup**: Built-in `development` and `production` Android flavors.

---

## 🧱 Architecture Overview

```text
lib/
├── main.dart                     # Application entrypoint
├── app/                          # App-level styles, network, & global logic
│   ├── common/                   # Shared exceptions & failures
│   ├── global/                   # App-wide logic (GlobalLogic, LocalLogic) & models
│   ├── network/                  # HTTP clients, interceptors, & API providers
│   └── theme/                    # Color schemes, typography, & styling
├── core/                         # Framework glue & environment bootstrap
│   ├── app_component.dart        # Root GetMaterialApp widget
│   ├── app_pages.dart            # Route definitions & page bindings
│   ├── app_routes.dart           # Route name constants
│   ├── dependency_injection.dart # Initial dependency injector
│   ├── env.dart                  # Config loaded via String.fromEnvironment
│   └── session.dart              # SharedPreferences session helper
├── features/core/                # Feature module (Clean Architecture)
│   ├── application/              # Use cases / services orchestration
│   ├── domain/                   # Business entities & repository interfaces
│   │   ├── interface/            # Abstract contracts (KomikRepositoryBase)
│   │   └── model/                # Request & response data models
│   ├── infrastructure/           # Data sources & repository implementations
│   │   ├── data_source/          # Remote HTTP / REST data sources
│   │   └── repository/           # Repository implementations
│   └── presentation/             # UI layer
│       └── homepage/             # HomeLogic + HomeState + HomePage (UI)
└── shared/                       # Reusable domain-agnostic utilities
    ├── log/                      # Logger wrapper
    ├── notif/                    # Local notifications service
    ├── size/                     # Device viewport & responsive utilities
    └── widget/                   # Reusable mobile layout widgets
```

---

## 🛠️ Tech Stack & Requirements

| Component | Technology | Version / Spec |
| :--- | :--- | :--- |
| **Framework** | Flutter | `>= 3.47.x` (stable) |
| **Language** | Dart | `>= 3.13.x` |
| **State Management** | GetX | `^4.7.3` |
| **Network & Functional** | http / dartz | `^1.6.0` / `0.10.1` |
| **Local Notifications** | flutter_local_notifications | `^22.3.1` |
| **Persistence** | shared_preferences | `^2.5.5` |
| **Android Toolchain** | AGP / Gradle / KGP | `9.1.0` / `9.3.1` / `2.4.0` |
| **Android SDK** | compileSdk / targetSdk / minSdk | `36` / `36` / `23` |
| **Java** | OpenJDK | `Java 21` bytecode |

---

## ⚙️ Environment Configuration

Configuration values are injected at build/run time via `--dart-define` or `--dart-define-from-file`.

Copy the sample file to get started:

```bash
cp .env.example .env
```

### Config Variables

| Key | Description | Default (Development) |
| :--- | :--- | :--- |
| `APP_ENV` | Environment identifier (`development` or `production`) | `development` |
| `APP_NAME` | Display name of the application | `SkyKomik Dev` |
| `BE_URL` | Base endpoint for the backend API | `https://be.demo.my.id` |
| `BASE_URL` | Root URL for web / remote resources | `https://demo.id` |
| `IMAGE_URL` | Asset CDN or remote image path | `https://demo.id/file/` |
| `WEBSOCKET_URL` | WebSocket gateway URL | `wss://demo.id/websocket` |
| `DB_NAME` | Local storage namespace | `DemoAppsDev` |

---

## 🚀 Running & Building

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run Locally

**Development (default environment):**
```bash
flutter run --flavor development
```

**Development with custom `.env` file:**
```bash
flutter run --flavor development --dart-define-from-file=.env
```

**Production:**
```bash
flutter run --flavor production \
  --dart-define=APP_ENV=production \
  --dart-define=APP_NAME=SkyKomik \
  --dart-define=BE_URL=https://be.demo.id \
  --dart-define=BASE_URL=http://demo.id \
  --dart-define=IMAGE_URL=http://demo.id/file/ \
  --dart-define=DB_NAME=DemoSuperApps
```

### 3. Build Release Artifacts

**Android APK (Development / Testing):**
```bash
flutter build apk --flavor development --debug
```

**Android App Bundle (Google Play Store Release):**
```bash
flutter build appbundle --flavor production --release --dart-define-from-file=.env
```

---

## 🧪 Quality & Verification

Run static code analysis before submitting changes:

```bash
flutter analyze
```

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.
