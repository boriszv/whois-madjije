abstract class IWhoisApi {
  Future<Map<String, dynamic>> getWhoisData(String domain);
}
