import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whois_madjije/services/iwhois_api.dart';

class WhoisApi implements IWhoisApi {

  @override
  Future<Map<String, dynamic>> getWhoisData(String domain) async {
    final url = 'https://www.whoisxmlapi.com/whoisserver/WhoisService?apiKey=at_O4bYh0lgE9khjzccJBtA2VJwMWlP9&domainName=$domain&outputFormat=JSON';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception();
    }

    return json.decode(response.body);
  }
}
