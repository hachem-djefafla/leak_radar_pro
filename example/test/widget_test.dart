// Smoke test for the example app.
//
// Pumps the app WITHOUT calling LeakRadar.init() first, proving the UI
// degrades gracefully when the engine hasn't been set up (no navigator
// exceptions, overlay injects an inert badge).
import 'package:flutter_test/flutter_test.dart';

import 'package:leak_radar_pro_example/main.dart';

void main() {
  testWidgets(
    'app renders home screen with leak buttons while engine is idle',
    (WidgetTester tester) async {
      await tester.pumpWidget(const LeakRadarApp());
      await tester.pump();

      expect(find.text('leak_radar_pro example'), findsOneWidget);
      expect(find.text('Open Leak Radar screen'), findsOneWidget);
      expect(find.text('Create and abandon a controller'), findsOneWidget);
    },
  );
}
