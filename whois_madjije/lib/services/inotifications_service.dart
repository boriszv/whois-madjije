class WhoisNotification {
  final String type;
  final String deviceToken;
  final String domain;
  final String expirationDateTime;
  final String status;

  WhoisNotification({
    required this.type,
    required this.deviceToken,
    required this.domain,
    required this.expirationDateTime,
    required this.status});

  factory WhoisNotification.fromJson(Map<String, dynamic> map) {
    return WhoisNotification(
      type: map['type'],
      deviceToken: map['deviceToken'],
      domain: map['domain'],
      expirationDateTime: map['expirationDateTime'],
      status: map['status'],
    );
  }
}

abstract class INotificationsService {
  Future<WhoisNotification?> getNotification(String domain, { String? deviceToken, String? email });
  Future<void> cancelNotification(String domain);
  Future<void> addNotification(WhoisNotification notification);
}
