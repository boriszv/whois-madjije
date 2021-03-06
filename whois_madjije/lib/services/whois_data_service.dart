import 'dart:io';

import 'package:whois_madjije/services/isearch_history_service.dart';
import 'package:whois_madjije/services/isettings_service.dart';
import 'package:whois_madjije/services/iwhois_api.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';

class WhoisDataService implements IWhoisDataService {

  final IWhoisApi _api;
  final ISearchHistoryService _searchHistory;
  final ISettingsService _settings;

  WhoisDataService(this._api, this._searchHistory, this._settings);

  @override
  Stream<List<DomainAvailability>> getAvailabilityList(String domain) async* {
    final domains = await _settings.getSavedDomainsList();

    final list = <DomainAvailability>[];
    for (final domainName in domains) {
      final result = await getWhoisData(domain + domainName, writeToHistory: false);
      list.add(DomainAvailability(
        domainName: domain + domainName,
        isRegistered: result.exists,
        valid: result.valid,
      ));
      yield list;
    }
  }

  @override
  Future<WhoisData> getWhoisData(String domain, {bool writeToHistory = true}) async {
    final results = await Future.wait([
      _api.getWhoisData(domain),
      _api.getIps(domain),
    ]);

    final result = results[0] as Map<String, dynamic>;
    final ips = (results[1] as List<InternetAddress>)
      .map((e) => e.address)
      .toList();

    final record = result['WhoisRecord'];

    if (result['ErrorMessage'] != null) {
      return WhoisData(
        exists: false,
        valid: false,
      );
    }

    if (record['dataError'] == 'MISSING_WHOIS_DATA') {
      if (writeToHistory) {
        await _addSearchRecod(domain, false);
      }

      return WhoisData.missingData();
    }

    if (record['registryData']?['rawText']?.toLowerCase()?.contains('invalid') == true) {
      return WhoisData(
        exists: false,
        valid: false,
      );
    }

    final data = WhoisData(
      exists: true,
      valid: true,

      domainName: record['domainName'],

      createdDate: record['registryData']['createdDate'],
      updatedDate: record['registryData']['updatedDate'],
      expiresDate: record['registryData']['expiresDate'],

      registrantName: record['registryData']?['registrant']?['name'],

      registrantOrganization: record['registrant']?['organization'],
      registrantState: record['registrant']?['state'],
      registrantCountry: record['registrant']?['country'],
      registrantCountryCode: record['registrant']?['countryCode'],

      administrativeContactOrganization: record['administrativeContact']?['organization'],
      administrativeContactState: record['administrativeContact']?['state'],
      administrativeContactCountry: record['administrativeContact']?['country'],
      administrativeContactCountryCode: record['administrativeContact']?['countryCode'],

      technicalContactOrganization: record['technicalContact']?['organization'],
      technicalContactState: record['technicalContact']?['state'],
      technicalContactCountry: record['technicalContact']?['country'],
      technicalContactCountryCode: record['technicalContact']?['countryCode'],

      registrarName: record['registrarName'],
      registrarIANAID: record['registrarIANAID'],
      contactEmail: record['contactEmail'],

      nameServers: _first([
        record['nameServers']?['hostNames'],
        record['registryData']?['nameServers']?['hostNames'],
        <String>[]
      ]),

      ips: ips,
    );

    if (writeToHistory) {
      await _addSearchRecod(domain, true);
    }
  
    return data;
  }

  Future<void> _addSearchRecod(String domain, bool isRegistered) async {
    await _searchHistory.addSearchRecord(SearchHistoryRecord(
      domainName: domain,
      dateTime: DateTime.now(),
      isRegistered: isRegistered
    ));
  }
}

List<String> _first(List<dynamic> data) {
  for (final item in data) {
    if (item != null) {
      return List<String>.from(item);
    }
  }
  return [];
}
