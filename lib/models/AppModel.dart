import 'package:app/models/abstract_model.dart';
import 'package:app/themes.dart';

/// //////////////////////////////////////////////////////
/// APP MODEL - Holds global state/settings for various app components and views.
/// A mix of different values: Current theme, app version, settings, online status, selected sections etc.
/// Some of the values are serialized in app.settings file
class AppModel extends AbstractModel {
  static const kCurrentVersion = "1.1.0";

  static bool get enableShadowsOnWeb => true;

  static bool get enableAnimationsOnWeb => true;

  /// Toggle fpsMeter
  static bool get showFps => false;

  /// Toggle Sketch Design Grid
  static bool get showDesignGrid => false;

  /// Ignore limiting cooldown periods (tweets, git events, git repos, groups), always fetch for each request
  static bool get ignoreCooldowns => false;

  AppModel() {
  }

  /// //////////////////////////////////////////////////
  /// Version Info (serialized)
  String version = "0.0.0";

  void upgradeToVersion(String value) {
    // Any version specific upgrade checks can go here
    version = value;
  }

  /// Current connection status
  bool get isOnline => _isOnline;
  bool _isOnline = true;

  set isOnline(bool value) {
    _isOnline = value;
    notifyListeners();
  }

  /// //////////////////////////////////////////
  /// Current Theme (serialized)
  ThemeType get theme => _theme;
  ThemeType _theme = ThemeType.Light;

  set theme(ThemeType value) {
    _theme = value;
    notifyListeners();
  }

  @override
  void copyFromJson(Map<String, dynamic> json) {
    var v = ThemeType.values;
    int theme = json["_theme"] ?? 0;
    _theme = v[theme.clamp(0, v.length)];
    version = json['version'] ?? "0.0.0";
  }

  @override
  Map<String, dynamic> toJson() => {
        "_theme": _theme.index,
        'version': version,
      };

  /// [SB] Just for easy testing, remove later
  void nextTheme() {
    theme = (theme == ThemeType.Dark) ? ThemeType.Light : ThemeType.Dark;
  }
}
