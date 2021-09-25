import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_madjije/services/isearch_history_service.dart';

enum SearchHistoryDatabaseProvider {
  memory,
  fileSystem,
}

class SearchHistoryService implements ISearchHistoryService {

  final SearchHistoryDatabaseProvider _provider;

  SearchHistoryService(this._provider);

  @override
  Future<List<SearchHistoryRecord>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('search_history') ?? '[]';

    final List<dynamic> jsonData = json.decode(historyJson);

    final List<SearchHistoryRecord> list = jsonData
      .map((x) => SearchHistoryRecord(
        domainName: x['domainName'],
        dateTime: DateTime.parse(x['dateTime']),
        isRegistered: x['isRegistered']
      ))
      .toList();

    list.sort((x, y) => y.dateTime.compareTo(x.dateTime));

    return list;
  }

  @override
  Future<void> addSearchRecord(SearchHistoryRecord record) async {
    final prefs = await SharedPreferences.getInstance();

    final historyJson = prefs.getString('search_history') ?? '[]';

    final jsonData = json.decode(historyJson) as List<dynamic>;

    jsonData.add({
      'domainName': record.domainName,
      'dateTime': record.dateTime.toIso8601String(),
      'isRegistered': record.isRegistered,
    });

    await prefs.setString('search_history', json.encode(jsonData));
  }
}
