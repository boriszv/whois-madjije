import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_madjije/services/isettings_service.dart';

class SettingsService implements ISettingsService {

  @override
  Future<bool> getDarkMode()
    async => (await SharedPreferences.getInstance()).getBool('darkmode') ?? false;

  @override
  Future<void> setDarkMode(bool darkMode)
    async => (await SharedPreferences.getInstance()).setBool('darkmode', darkMode);

  @override
  Future<String?> getEmailForNotifications() async {
    final settings = await getNotificationSettings();
    return settings.email;
  }

  @override
  Future<String> getLanguage()
    async => (await SharedPreferences.getInstance()).getString('language') ?? 'en';

  @override
  Future<void> setLanguage(String language) 
    async => (await SharedPreferences.getInstance()).setString('language', language);

  @override
  Future<NotificationSettings> getNotificationSettings() async {
    final data = (await SharedPreferences.getInstance()).getString('notification_settings');
    if (data == null) {
      return NotificationSettings(
        email: null,
        type: NotificationType.push,
      );
    }

    final settings = json.decode(data);
    return NotificationSettings(
      email: settings['email'],
      type: NotificationType.values[settings['type']],
    );
  }

  @override
  Future<void> setNotificationSettings(NotificationSettings settings)
    async => (await SharedPreferences.getInstance()).setString('notification_settings', json.encode({
      'email': settings.email,
      'type': settings.type.index,
    }));

  @override
  Future<List<String>> getSavedDomainsList() async {
    final data = (await SharedPreferences.getInstance()).getString('saved_domains');
    if (data == null || data.isEmpty) {
      return defaultDomains.map((x) => x).toList();
    }

    return (json.decode(data) as List<dynamic>).cast<String>();
  }

  @override
  Future<void> updateSavedDomains(List<String> domains)
    async => (await SharedPreferences.getInstance()).setString('saved_domains', json.encode(domains));
}

const defaultDomains = [
  '.rs',
  '.срб',
  '.ru',
  '.рф',
  '.mk',
  '.мкд',
  '.org',
  '.орг',
  '.com',
  '.ком',
  '.net',
  '.uk',
  '.se',
  '.io',
  '.gov'
];
