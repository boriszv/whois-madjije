import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_madjije/services/isearch_history_service.dart';

enum SearchHistoryDatabaseProvider {
  memory,
  fileSystem,
}

class SearchHistoryService implements ISearchHistoryService {

  @override
  Future<List<SearchHistoryRecord>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('search_history') ?? '[]';

    final List<dynamic> jsonData = json.decode(historyJson);

    final List<SearchHistoryRecord> list = _parseList(jsonData);

    list.sort((x, y) => y.dateTime.compareTo(x.dateTime));

    return list;
  }

  @override
  Future<void> addSearchRecord(SearchHistoryRecord record) async {
    final prefs = await SharedPreferences.getInstance();

    final historyJson = prefs.getString('search_history') ?? '[]';

    var jsonData = json.decode(historyJson) as List<dynamic>;

    final list = _parseList(jsonData);
    final existingRecord = list.firstWhere((x) => record.domainName == x.domainName,
      orElse: () => SearchHistoryRecord.empty());

    if (existingRecord.isEmpty()) {
      jsonData.add(record.toJson());

    } else {
      final index = list.indexOf(existingRecord);
      existingRecord.dateTime = record.dateTime;

      list[index] = existingRecord;

      jsonData = list.map((x) => x.toJson()).toList();
    }

    await prefs.setString('search_history', json.encode(jsonData));
  }

  List<SearchHistoryRecord> _parseList(List<dynamic> jsonData) {
    return jsonData
      .map((x) => SearchHistoryRecord(
        domainName: x['domainName'],
        dateTime: DateTime.parse(x['dateTime']),
        isRegistered: x['isRegistered']
      ))
      .toList();
  }
}
