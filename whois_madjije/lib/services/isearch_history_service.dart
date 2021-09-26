class SearchHistoryRecord {
  String domainName;
  DateTime dateTime;
  bool isRegistered;

  SearchHistoryRecord({
    required this.domainName,
    required this.dateTime,
    required this.isRegistered});

  bool isEmpty() => domainName == '!empty!';

  factory SearchHistoryRecord.empty() {
    return SearchHistoryRecord(
      dateTime: DateTime.now(),
      domainName: '!empty!',
      isRegistered: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domainName': domainName,
      'dateTime': dateTime.toIso8601String(),
      'isRegistered': isRegistered,
    };
  }
}

abstract class ISearchHistoryService {

  abstract Stream<bool> updated$;

  Future<List<SearchHistoryRecord>> getSearchHistory();
  Future<void> addSearchRecord(SearchHistoryRecord record);
}
