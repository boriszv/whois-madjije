import 'dart:io';

abstract class IWhoisApi {
  Future<Map<String, dynamic>> getWhoisData(String domain);
  Future<List<InternetAddress>> getIps(String? domain);
}
