enum NotificationType {
  email,
  push,
}

class NotificationSettings {
  final NotificationType type;
  final String? email;

  NotificationSettings({
    required this.type,
    required this.email});
}

abstract class ISettingsService {

  Future<String?> getEmailForNotifications();
  Future<void> setEmailForNotifications(String email);

  Future<String> getLanguage();
  Future<void> setLanguage(String language);

  Future<NotificationSettings> getNotificationSettings();
  Future<void> setNotificationSettings(NotificationSettings settings);

  Future<bool> getDarkMode();
  Future<void> setDarkMode(bool language);
}
