import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:whois_madjije/services/iwhois_api.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';
import 'package:whois_madjije/services/whois_data_service.dart';

import 'domain_data.dart';
import 'whois_data_service_test.mocks.dart';

@GenerateMocks([IWhoisApi], customMocks: [MockSpec<IWhoisApi>(as: #MockWhoisApi, returnNullOnMissingStub: false)])
void main() {
  group('WhoisDataService Tests', () {

    test('google.com', () async {
      final api = MockWhoisApi();

      when(api.getWhoisData(any)) 
        .thenAnswer((_) async => googleCom);

      final service = WhoisDataService(api);

      final result = await service.getWhoisData('google.com');
      expect(result.exists, true);

      verifyDates(result);

      expect(result.registrantName, isNull);

      verifyRegistrantExists(result);
      verifyAdministrativeContactExists(result);
      verifyTechnicalContactExists(result);

      expect(result.registrarName, isNotNull);
      expect(result.registrarName, isNotEmpty);

      expect(result.registrarIANAID, isNotNull);
      expect(result.registrarIANAID, isNotEmpty);

      expect(result.contactEmail, isNotNull);
      expect(result.contactEmail, isNotEmpty);

      expect(result.nameServers.length, 4);
    });
  
    test('гугл.мкд', () async {
      final api = MockWhoisApi();

      when(api.getWhoisData(any)) 
        .thenAnswer((_) async => googleMKD);

      final service = WhoisDataService(api);

      final result = await service.getWhoisData('гугл.мкд');

      expect(result.exists, true);

      verifyDates(result);

      expect(result.registrantName, isNotNull);

      expect(result.registrarName, isNotNull);
      expect(result.registrarName, isNotEmpty);

      expect(result.registrarIANAID, isNotNull);
      expect(result.registrarIANAID, isNotEmpty);

      expect(result.contactEmail, isNotNull);
      expect(result.contactEmail, isNotEmpty);

      expect(result.nameServers.length, 2);
    });

    test('nonexistent domain', () async {
      final api = MockWhoisApi();

      when(api.getWhoisData(any)) 
        .thenAnswer((_) async => missingWhoisData);

      final service = WhoisDataService(api);

      final result = await service.getWhoisData('randomdomain.com');

      expect(result.exists, false);
    });
  });
}

void verifyDates(WhoisData result) {
  expect(result.createdDate, isNotNull);
  expect(result.createdDate, isNotEmpty);

  expect(result.updatedDate, isNotNull);
  expect(result.updatedDate, isNotEmpty);

  expect(result.expiresDate, isNotNull);
  expect(result.expiresDate, isNotEmpty);
}

void verifyRegistrantExists(WhoisData result) {
  expect(result.registrantOrganization, isNotNull);
  expect(result.registrantOrganization, isNotEmpty);

  expect(result.registrantState, isNotNull);
  expect(result.registrantState, isNotEmpty);

  expect(result.registrantCountry, isNotNull);
  expect(result.registrantCountry, isNotEmpty);

  expect(result.registrantCountryCode, isNotNull);
  expect(result.registrantCountryCode, isNotEmpty);
}

void verifyAdministrativeContactExists(WhoisData result) {
  expect(result.administrativeContactOrganization, isNotNull);
  expect(result.administrativeContactOrganization, isNotEmpty);

  expect(result.administrativeContactState, isNotNull);
  expect(result.administrativeContactState, isNotEmpty);

  expect(result.administrativeContactCountry, isNotNull);
  expect(result.administrativeContactCountry, isNotEmpty);

  expect(result.administrativeContactCountryCode, isNotNull);
  expect(result.administrativeContactCountryCode, isNotEmpty);
}

void verifyTechnicalContactExists(WhoisData result) {
  expect(result.technicalContactOrganization, isNotNull);
  expect(result.technicalContactOrganization, isNotEmpty);

  expect(result.technicalContactState, isNotNull);
  expect(result.technicalContactState, isNotEmpty);

  expect(result.technicalContactCountry, isNotNull);
  expect(result.technicalContactCountry, isNotEmpty);

  expect(result.technicalContactCountryCode, isNotNull);
  expect(result.technicalContactCountryCode, isNotEmpty);
}
