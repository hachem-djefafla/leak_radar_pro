import 'package:leak_radar_pro/src/leak_analysis/src/analysis/app_package_set.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPackageSet', () {
    test('from() matches package: libraries by name', () {
      final s = AppPackageSet.from(['my_app']);
      expect(s.contains(Uri.parse('package:my_app/main.dart')), isTrue);
      expect(s.contains(Uri.parse('package:flutter/widgets.dart')), isFalse);
      expect(s.contains(Uri.parse('dart:core')), isFalse);
    });

    test('autoDetect drops SDK/framework packages, keeps app packages', () {
      final s = AppPackageSet.autoDetect([
        Uri.parse('package:my_app/main.dart'),
        Uri.parse('package:flutter/widgets.dart'),
        Uri.parse('dart:core'),
      ]);
      expect(s.contains(Uri.parse('package:my_app/x.dart')), isTrue);
      expect(s.contains(Uri.parse('package:flutter/x.dart')), isFalse);
    });
  });
}
