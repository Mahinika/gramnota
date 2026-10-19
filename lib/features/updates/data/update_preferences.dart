import 'package:shared_preferences/shared_preferences.dart';

const lastUpdateCheckKey = 'update_last_check_ms';
const skippedUpdateBuildKey = 'update_skipped_build';

abstract class UpdatePreferences {
  Future<DateTime?> lastCheck();

  Future<void> setLastCheck(DateTime time);

  Future<int?> skippedBuild();

  Future<void> setSkippedBuild(int build);
}

class MemoryUpdatePreferences implements UpdatePreferences {
  DateTime? storedCheck;
  int? storedSkip;

  @override
  Future<DateTime?> lastCheck() async => storedCheck;

  @override
  Future<void> setLastCheck(DateTime time) async {
    storedCheck = time;
  }

  @override
  Future<int?> skippedBuild() async => storedSkip;

  @override
  Future<void> setSkippedBuild(int build) async {
    storedSkip = build;
  }
}

class SharedUpdatePreferences implements UpdatePreferences {
  SharedUpdatePreferences(this._preferences);

  final SharedPreferences _preferences;

  static Future<SharedUpdatePreferences> load() async {
    return SharedUpdatePreferences(await SharedPreferences.getInstance());
  }

  @override
  Future<DateTime?> lastCheck() async {
    final millis = _preferences.getInt(lastUpdateCheckKey);
    if (millis == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
  }

  @override
  Future<void> setLastCheck(DateTime time) {
    return _preferences.setInt(
      lastUpdateCheckKey,
      time.toUtc().millisecondsSinceEpoch,
    );
  }

  @override
  Future<int?> skippedBuild() async => _preferences.getInt(skippedUpdateBuildKey);

  @override
  Future<void> setSkippedBuild(int build) {
    return _preferences.setInt(skippedUpdateBuildKey, build);
  }
}
