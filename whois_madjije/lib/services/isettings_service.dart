enum NotificationType {
  email,
  push,
}

class NotificationSettings {
  NotificationType type;
  String? email;

  NotificationSettings({
    required this.type,
    this.email});
}

abstract class ISettingsService {

  Future<String?> getEmailForNotifications();

  Future<String> getLanguage();
  Future<void> setLanguage(String language);

  Future<NotificationSettings> getNotificationSettings();
  Future<void> setNotificationSettings(NotificationSettings settings);

  Future<bool> getDarkMode();
  Future<void> setDarkMode(bool darkMode);

  Future<List<String>> getSavedDomainsList();
  Future<void> updateSavedDomains(List<String> domains);
}
