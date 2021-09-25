import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_madjije/services/isettings_service.dart';

class SettingsService implements ISettingsService {

  late SharedPreferences instance;

  SettingsService() {
    SharedPreferences.getInstance().then((value) {
      instance = value;
    });
  }

  @override
  Future<bool> getDarkMode()
    async => instance.getBool('darkmode') ?? false;

  @override
  Future<void> setDarkMode(bool darkMode)
    => instance.setBool('darkmode', darkMode);

  @override
  Future<String?> getEmailForNotifications() async {
    final settings = await getNotificationSettings();
    return settings.email;
  }

  @override
  Future<String> getLanguage()
    async => instance.getString('language') ?? 'sr';

  @override
  Future<void> setLanguage(String language) 
    => instance.setString('language', language);

  @override
  Future<NotificationSettings> getNotificationSettings() async {
    final data = instance.getString('notification_settings');
    if (data == null) {
      return NotificationSettings(
        email: null,
        type: NotificationType.push,
      );
    }

    final settings = json.decode(data);
    return NotificationSettings(
      email: settings['email'],
      type: settings['type'],
    );
  }

  @override
  Future<void> setNotificationSettings(NotificationSettings settings)
    => instance.setString('notification_settings', json.encode({
      'email': settings.email,
      'type': settings.type,
    }));
}
