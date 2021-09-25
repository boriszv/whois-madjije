
// @GenerateMocks([IWhoisApi], customMocks: [MockSpec<IWhoisApi>(as: #MockWhoisApi, returnNullOnMissingStub: false)])
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_madjije/services/isearch_history_service.dart';
import 'package:whois_madjije/services/search_history_service.dart';

void main() {
  group('SearchHistoryService getAvailabilityList Tests', () {

    setUp(() async {
      (await SharedPreferences.getInstance()).remove('search_history');
    });

    test('addSearchRecord', () async {
      final service = SearchHistoryService();

      await service.addSearchRecord(SearchHistoryRecord(
        dateTime: DateTime.now(),
        domainName: 'prioritysoft.io',
        isRegistered: true,
      ));

      final results = await service.getSearchHistory();
      expect(results.length, isNot(0));
    });

    test('sorting', () async {
      final service = SearchHistoryService();

      await service.addSearchRecord(SearchHistoryRecord(
        dateTime: DateTime.now(),
        domainName: 'prioritysoft.io',
        isRegistered: true,
      ));
      
      await service.addSearchRecord(SearchHistoryRecord(
        dateTime: DateTime.now().add(const Duration(seconds: 3)),
        domainName: 'prioritysoft.net',
        isRegistered: true,
      ));

      final results = await service.getSearchHistory();
      expect(results.length, isNot(0));
      expect(results.first.domainName, 'prioritysoft.net');
    });

    test('update existing', () async {
      final service = SearchHistoryService();

      await service.addSearchRecord(SearchHistoryRecord(
        dateTime: DateTime.now(),
        domainName: 'prioritysoft.io',
        isRegistered: true,
      ));
      
      await service.addSearchRecord(SearchHistoryRecord(
        dateTime: DateTime.now().add(const Duration(seconds: 3)),
        domainName: 'prioritysoft.net',
        isRegistered: true,
      ));

      await service.addSearchRecord(SearchHistoryRecord(
        dateTime: DateTime.now().add(const Duration(seconds: 10)),
        domainName: 'prioritysoft.io',
        isRegistered: true,
      ));

      final results = await service.getSearchHistory();
      expect(results.length, 2);
      expect(results.first.domainName, 'prioritysoft.io');
    });
  });
}
