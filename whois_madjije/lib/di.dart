import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/isearch_history_service.dart';
import 'package:whois_madjije/services/iwhois_api.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';
import 'package:whois_madjije/services/search_history_service.dart';
import 'package:whois_madjije/services/whois_api.dart';
import 'package:whois_madjije/services/whois_data_service.dart';

void setupDependencyInjection() {
  GetIt.I.registerFactory<IWhoisApi>(() => WhoisApi());
  
  GetIt.I.registerFactory<ISearchHistoryService>(() => SearchHistoryService());

  GetIt.I.registerFactory<IWhoisDataService>(() =>
    WhoisDataService(
      GetIt.I<IWhoisApi>(),
      GetIt.I<ISearchHistoryService>(),
    ));
}
