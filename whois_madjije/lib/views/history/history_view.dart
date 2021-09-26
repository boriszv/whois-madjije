import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/isearch_history_service.dart';
import 'package:whois_madjije/views/domain_detail/domain_detail.dart';
import 'package:whois_madjije/views/domain_list/domain_info_widget.dart';
import 'package:whois_madjije/views/sharedWidgets/loading_widget.dart';

import '../../app_localizations.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final searchHistoryService = GetIt.I<ISearchHistoryService>();
  List<SearchHistoryRecord> searchHistoryRecordList = [];

  var isLoading = true;

  @override
  void initState() {
    super.initState();

    searchHistoryService.updated$.listen((event) {
      _fetchHistory();
    });

    _fetchHistory();
  }

  void _fetchHistory() {
    searchHistoryService.getSearchHistory().then((result) {
      setState(() {
        searchHistoryRecordList = result;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: Text(translations.translate('Istorija')),
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        itemCount: searchHistoryRecordList.length + 1,
        itemBuilder: (context, itemIndex) {
          return itemIndex < searchHistoryRecordList.length
              ? DomainInfo(
                  domainName: searchHistoryRecordList[itemIndex].domainName,
                  isRegistered: searchHistoryRecordList[itemIndex].isRegistered,
                  icon: Icons.chevron_right,
                  iconColor: Colors.black,
                  date: searchHistoryRecordList[itemIndex].dateTime,
                  isHistoryIconShown: true,
                  onCardPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                      DomainDetail(domain: searchHistoryRecordList[itemIndex].domainName)));
                  },
                )
              : LoadingIndicator(isLoading: isLoading);
        },
      ),
    );
  }
}
