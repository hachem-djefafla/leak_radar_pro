/// `dart:io`-backed helpers for the vendored leak-analysis engine.
///
/// The main `package:leak_radar_pro/leak_radar_pro.dart` library is pure Dart
/// so it stays safe to import from web-hosted consumers (e.g. a DevTools
/// extension). Anything that needs file-system access — such as detecting
/// the app's own package names from a project directory, for feeding
/// `AppPackageSet`/`OriginClassifier` an explicit config instead of relying on
/// auto-detection — lives here instead, behind an opt-in import.
library;

export 'src/io/project_packages_io.dart';
