class DomainAvailability {
  final String domainName;
  final bool isRegistered;

  DomainAvailability({
    required this.domainName,
    required this.isRegistered});
}

class WhoisData {

  final bool exists;
  final bool valid;

  final String? domainName;

  final String? createdDate;
  final String? updatedDate;
  final String? expiresDate;

  // if there is no data for "organization", "state" and so on display this name if available
  final String? registrantName;

  final String? registrantOrganization;
  final String? registrantState;
  final String? registrantCountry;
  final String? registrantCountryCode;

  final String? administrativeContactOrganization;
  final String? administrativeContactState;
  final String? administrativeContactCountry;
  final String? administrativeContactCountryCode;

  final String? technicalContactOrganization;
  final String? technicalContactState;
  final String? technicalContactCountry;
  final String? technicalContactCountryCode;

  final String? registrarName;
  final String? registrarIANAID;

  final String? contactEmail;

  final List<String> nameServers;

  WhoisData({
    required this.exists,
    required this.valid,
    this.domainName,
    this.createdDate,
    this.updatedDate,
    this.expiresDate,
    this.registrantName,
    this.registrantOrganization,
    this.registrantState,
    this.registrantCountry,
    this.registrantCountryCode,
    this.administrativeContactOrganization,
    this.administrativeContactState,
    this.administrativeContactCountry,
    this.administrativeContactCountryCode,
    this.technicalContactOrganization,
    this.technicalContactState,
    this.technicalContactCountry,
    this.technicalContactCountryCode,
    this.registrarName,
    this.registrarIANAID,
    this.contactEmail,

    this.nameServers = const []});

  factory WhoisData.missingData() {
    return WhoisData(
      valid: false,
      exists: false,
    );
  }
}

abstract class IWhoisDataService {

  // Get Whois data for individual domain
  Future<WhoisData> getWhoisData(String domain);

  // Get availability list of domains
  Stream<List<DomainAvailability>> getAvailabilityList(String domain);
}
