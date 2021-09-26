import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';
import 'package:whois_madjije/views/sharedWidgets/loading_widget.dart';

import '../../app_localizations.dart';
import 'domain_info_widget.dart';

class DomainList extends StatefulWidget {
  final String domain;

  const DomainList({Key? key, required this.domain}) : super(key: key);

  @override
  State<DomainList> createState() => _DomainListState();
}

class _DomainListState extends State<DomainList> {
  final domainListService = GetIt.I<IWhoisDataService>();
  List<DomainAvailability> domainAvailabilityList = [];

  var isLoading = true;

  @override
  void initState() {
    super.initState();

    domainListService.getAvailabilityList(widget.domain).listen((result) {
      setState(() {
        domainAvailabilityList = result;
      });
    }, onDone: () {
      setState(() {
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
        title: Text(translations.translate('Domeni')),
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        itemCount: domainAvailabilityList.length + 1,
        itemBuilder: (context, itemIndex) {
          return itemIndex < domainAvailabilityList.length
              ? DomainInfo(
                  domainName: domainAvailabilityList[itemIndex].domainName,
                  isRegistered: domainAvailabilityList[itemIndex].isRegistered,
                  icon: Icons.chevron_right,
                  iconColor: Colors.black,
                  onCardPressed: () {},
                )
              : LoadingIndicator(isLoading: isLoading);
        },
      ),
    );
  }
}
