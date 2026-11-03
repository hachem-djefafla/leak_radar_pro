# Leak History

Package name: `leak_radar_pro`
This package supersedes `leak_radar_pro`.

## 0.1.1

- Shortened the package description to satisfy pub.dev metadata limits
  (no functional changes; 0.1.0 was skipped due to a republish).

## 0.1.0

Initial release of the renamed package.

- Zero-config on-device memory-leak detector: per-class heap growth +
  precise object retention (`track()` opt-in) in debug/profile builds,
  complete no-op in release.
- Built-in inspector screens (findings, class detail, retaining paths),
  overlay badge, and export (Markdown/JSON).
- Ship-ready DevTools extension (`Leak Radar` tab: heap capture, class
  histogram, diff, retaining paths) — served from `extension/devtools/`.
- Bundles a private design system and heap-analysis engine
  (`lib/src/ui_kit`, `lib/src/leak_analysis`) — single package, one version.

The public API is identical to `leak_radar_pro` 0.3.x except the package
name — swap the import and you're done.
