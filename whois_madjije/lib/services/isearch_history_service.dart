class SearchHistoryRecord {
  final String domainName;
  final DateTime dateTime;
  final bool isRegistered;

  SearchHistoryRecord({
    required this.domainName,
    required this.dateTime,
    required this.isRegistered});
}

abstract class ISearchHistoryService {
  Future<List<SearchHistoryRecord>> getSearchHistory();
  Future<void> addSearchRecord(SearchHistoryRecord record);
}
