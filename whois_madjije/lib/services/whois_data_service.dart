import 'package:whois_madjije/services/isearch_history_service.dart';
import 'package:whois_madjije/services/iwhois_api.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';

class WhoisDataService implements IWhoisDataService {

  final IWhoisApi _api;
  final ISearchHistoryService _searchHistory;

  WhoisDataService(this._api, this._searchHistory);

  @override
  Stream<List<DomainAvailability>> getAvailabilityList(String domain) async* {
    const domains = [
      '.rs',
      '.срб',
      '.ru',
      '.рф',
      '.mk',
      '.мкд',
      '.org',
      '.орг',
      '.com',
      '.ком',
      '.net',
      '.uk',
      '.se',
    ];

    final list = <DomainAvailability>[];
    for (final domainName in domains) {
      final result = await getWhoisData(domain + domainName);
      list.add(DomainAvailability(domainName: domainName, isRegistered: result.exists));
      yield list;
    }
  }

  @override
  Future<WhoisData> getWhoisData(String domain) async {
    final result = await _api.getWhoisData(domain);

    final record = result['WhoisRecord'];

    if (record['dataError'] == 'MISSING_WHOIS_DATA') {
      return WhoisData.missingData();
    }

    return WhoisData(
      exists: true,
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
        []
      ]),
    );
  }
}

dynamic _first(List<dynamic> data) {
  for (final item in data) {
    if (item != null) {
      return item;
    }
  }
}
