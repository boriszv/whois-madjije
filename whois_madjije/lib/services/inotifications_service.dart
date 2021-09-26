class WhoisNotification {
  final String type;
  final String deviceToken;
  final String domain;
  final String expirationDateTime;
  final String status;
  final String email;

  WhoisNotification({
    required this.type,
    required this.deviceToken,
    required this.domain,
    required this.expirationDateTime,
    required this.status,
    required this.email});

  factory WhoisNotification.fromJson(Map<String, dynamic> map) {
    return WhoisNotification(
      type: map['type'],
      deviceToken: map['deviceToken'],
      domain: map['domain'],
      expirationDateTime: map['expirationDateTime'],
      status: map['status'],
      email: map['email'],
    );
  }
}

abstract class INotificationsService {
  Future<WhoisNotification?> getNotification(String domain);
  Future<void> cancelNotification(String domain);
  Future<void> addNotification(WhoisNotification notification);
}
