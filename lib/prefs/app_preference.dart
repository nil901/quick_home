import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static final AppPreference _appPreference = AppPreference._internal();

  factory AppPreference() {
    return _appPreference;
  }

  AppPreference._internal();

  SharedPreferences? _preferences;

  Future<void> initialAppPreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String getString(String key, {String defValue = ''}) {
    return _preferences?.getString(key) != null
        ? (_preferences?.getString(key) ?? '')
        : defValue;
  }

  Future setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int getInt(String key, {int defValue = 0}) {
    return _preferences?.getInt(key) != null
        ? (_preferences?.getInt(key) ?? 0)
        : defValue;
  }

  Future setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool getBool(String key, {bool defValue = false}) {
    return _preferences?.getBool(key) ?? defValue;
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("✅ SharedPreferences cleared");
  }

  String get uName => getString(PreferencesKey.userId);

  // ----- Guest helpers -----
  Future<void> setGuest(bool value) async {
    await setBool(PreferencesKey.isGuest, value);
  }

  bool isGuest({bool defValue = false}) {
    return getBool(PreferencesKey.isGuest, defValue: defValue);
  }

  /// Create a simple local guest id and store it. This is a client-side
  /// convenience only; server APIs may not accept this id. If your backend
  /// supports anonymous sessions, prefer using a server endpoint instead.
  Future<void> createLocalGuestUser() async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    // Create a positive guest id within 9-digit range to avoid 0
    final guestId = (ts % 1000000000) + 100000;
    await setInt(PreferencesKey.userId, guestId);
    await setGuest(true);
    // mark not logged in
    await setBool(PreferencesKey.isLoggedIn, false);
  }
}
