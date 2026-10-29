# leak_radar_pro example

Minimal runnable example: `flutter run` inside this folder.

- `LeakRadar.init(LeakRadarConfig.standard(...))` configures the detector.
- The "**Create and abandon a controller**" button leaks a controller that is
  never disposed/cancelled — the detector reports it.
- `LeakRadarScreen` opens the findings UI; `LeakRadar.overlay` shows the badge;
  scanning happens on screen-pop and every 2 minutes.
