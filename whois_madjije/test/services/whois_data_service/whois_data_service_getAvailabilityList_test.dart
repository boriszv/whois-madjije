import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:whois_madjije/services/iwhois_api.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';
import 'package:whois_madjije/services/search_history_service.dart';
import 'package:whois_madjije/services/whois_data_service.dart';

import 'domain_data.dart';
import 'whois_data_service_getAvailabilityList_test.mocks.dart';

@GenerateMocks([IWhoisApi], customMocks: [MockSpec<IWhoisApi>(as: #MockWhoisApi, returnNullOnMissingStub: false)])
void main() {
  group('WhoisDataService getAvailabilityList Tests', () {

    test('google', () async {
      final api = MockWhoisApi();

      when(api.getWhoisData(any)) 
        .thenAnswer((_) async => googleMKD);

      final service = WhoisDataService(api, SearchHistoryService());

      final stream = service.getAvailabilityList('testdomen');
      await stream.last;

      verify(api.getWhoisData('testdomen.rs'));
      verify(api.getWhoisData('testdomen.срб'));
      verify(api.getWhoisData('testdomen.ru'));
      verify(api.getWhoisData('testdomen.рф'));
      verify(api.getWhoisData('testdomen.mk'));
      verify(api.getWhoisData('testdomen.мкд'));
      verify(api.getWhoisData('testdomen.org'));
      verify(api.getWhoisData('testdomen.орг'));
      verify(api.getWhoisData('testdomen.com'));
      verify(api.getWhoisData('testdomen.ком'));
      verify(api.getWhoisData('testdomen.net'));
      verify(api.getWhoisData('testdomen.uk'));
      verify(api.getWhoisData('testdomen.se'));
    });
  });
}
