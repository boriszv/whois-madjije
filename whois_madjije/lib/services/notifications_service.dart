
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whois_madjije/services/inotifications_service.dart';
import 'package:whois_madjije/services/isettings_service.dart';

class NotificationsService implements INotificationsService {

  final ISettingsService _settings;

  NotificationsService(this._settings);

  @override
  Future<WhoisNotification?> getNotification(String domain, { String? deviceToken, String? email }) async {
    final baseQuery = FirebaseFirestore.instance.collection('notifications')
      .where('domain', isEqualTo: domain);

    final email = await _settings.getEmailForNotifications();
    if (email != null) {
      final emailNotifications = await baseQuery.where('email', isEqualTo: email).get();
      if (emailNotifications.docs.isNotEmpty) {
        return WhoisNotification.fromJson(emailNotifications.docs.first.data());
      }
    }

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      final pushNotifications = await baseQuery.where('token', isEqualTo: token).get();
      if (pushNotifications.docs.isNotEmpty) {
        return WhoisNotification.fromJson(pushNotifications.docs.first.data());
      }
    }

    return null;
  }
 
  @override
  Future<void> cancelNotification(String domain) async {
    final baseQuery = FirebaseFirestore.instance.collection('notifications')
      .where('domain', isEqualTo: domain);

    final email = await _settings.getEmailForNotifications();
    if (email != null) {
      final emailNotifications = await baseQuery.where('email', isEqualTo: email).get();
      if (emailNotifications.docs.isNotEmpty) {
        await _cancelQueuedNotifications(emailNotifications);
      }
    }

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      final pushNotifications = await baseQuery.where('token', isEqualTo: token).get();
      if (pushNotifications.docs.isNotEmpty) {
        await _cancelQueuedNotifications(pushNotifications);
      }
    }
  }

  @override
  Future<void> addNotification(WhoisNotification notification) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'type': notification.type,
      'deviceToken': notification.deviceToken,
      'domain': notification.domain,
      'expirationDateTime': notification.expirationDateTime,
      'status': notification.status,
    });
  }

  Future<void> _cancelQueuedNotifications(QuerySnapshot<Map<String, dynamic>> notifications) async {
    for (final element in notifications.docs) {
      final data = element.data();
      if (data['status'] == 'queued') {
        await element.reference.update({
          'status': 'cancelled'
        });
      }
    }
  }
}
