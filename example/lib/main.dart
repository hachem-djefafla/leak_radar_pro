import 'package:flutter/material.dart';

import 'package:leak_radar_pro/leak_radar_pro.dart';

/// Minimal leak_radar_pro example.
///
/// Configure the detector once in `main`, wrap your home with
/// [LeakRadar.overlay], register [LeakRadar.navigatorObserver], and tap
/// around — the leaked controller appears in [LeakRadarScreen]. In debug and
/// profile builds this runs; in release the package is a complete no-op.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // One-call setup, safest defaults:
  await LeakRadar.init(
    LeakRadarConfig.standard(
      autoScan: AutoScan(
        onNavigation: true,
        period: const Duration(minutes: 2),
      ),
    ),
  );

  runApp(const LeakRadarApp());
}

class LeakRadarApp extends StatelessWidget {
  const LeakRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'leak_radar_pro example',
      theme: ThemeData.dark(useMaterial3: true),
      // Scan on every didPop (onNavigation):
      navigatorObservers: [LeakRadar.navigatorObserver],
      // Wrap your home to add the status overlay:
      home: LeakRadar.overlay(child: const ExampleHomeScreen()),
    );
  }
}

class ExampleHomeScreen extends StatelessWidget {
  const ExampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('leak_radar_pro example')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Open Leak Radar to inspect the findings screen. The leaky '
            'controller created below shows up once a scan runs.',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LeakRadarScreen()),
              );
            },
            child: const Text('Open Leak Radar screen'),
          ),
          ElevatedButton(
            // Precise tracking: a disposed-but-retained object is reported
            // after the configured number of GC cycles.
            onPressed: () => _createAndAbandonAController(),
            child: const Text('Create and abandon a controller'),
          ),
        ],
      ),
    );
  }
}

/// Holds a stream subscription created but never cancelled — a canonical leak.
void _createAndAbandonAController() {
  final _LeakySettingsController controller = _LeakySettingsController(
    started: true,
  );
  // NOTE: markDisposed is never called — nothing clears the subscription, so
  // the controller stays retained. LeakRadar.track registered it above, so a
  // later scan reports it as a leak. Creating one per press is intentional.
  // ignore: avoid_print
  debugPrint('abandoned controller: $controller');
}

class _LeakySettingsController {
  _LeakySettingsController({required bool started}) {
    if (started) _subscribe();
  }

  Stream<bool>? _source;

  void _subscribe() {
    final Stream<bool> s = _source ?? const Stream.empty();
    // The subscription is stored, never cancelled — retained for life.
    LeakRadar.track(this, tag: '_LeakySettingsController');
    debugPrint('subscribed (intentionally never cancelled in this demo)');
    // ignore: async_return_without_await, unawaited_futures
    s.listen(
      (_) {},
      onError: (Object e) {
        debugPrint('example stream error (expected in this demo): $e');
      },
    );
  }
}
