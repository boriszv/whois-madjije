import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whois_madjije/services/iwhois_api.dart';

class WhoisApi implements IWhoisApi {

  @override
  Future<Map<String, dynamic>> getWhoisData(String domain) async {
    final url = 'https://www.whoisxmlapi.com/whoisserver/WhoisService?apiKey=at_Ys51UVhn8VP882YeZKsg2hfpANesA&domainName=$domain&outputFormat=JSON';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception();
    }

    return json.decode(response.body);
  }

  @override
  Future<List<InternetAddress>> getIps(String? domain) {
    if (domain == null) {
      return Future.value([]);
    }

    return InternetAddress.lookup(domain).catchError((error) async {
      return <InternetAddress>[];
    });
  }
}
