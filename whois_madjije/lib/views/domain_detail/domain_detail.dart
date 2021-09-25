import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/app_localizations.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';

class DomainDetail extends StatefulWidget {

  final String domain;

  const DomainDetail({Key? key,
    required this.domain}) : super(key: key);

  @override
  State<DomainDetail> createState() => _DomainDetailState();
}

class _DomainDetailState extends State<DomainDetail> {
  
  final whoisDataService = GetIt.I<IWhoisDataService>();

  var loading = false;
  WhoisData? data;

  @override
  void initState() {
    super.initState();

    // setState(() { loading = true; });
    // whoisDataService.getWhoisData(widget.domain).then((result) {
    //   setState(() {
    //     data = result;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: const Text('Domain Detail'),
      ),
      floatingActionButton: _FloatingButton(),
    );
  }
}

class _FloatingButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.star_border, color: Theme.of(context).primaryColor),
              const SizedBox(width: 20),
              Text(translations.translate('Dodaj u omiljeno')),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.notifications_none, color: Theme.of(context).primaryColor),
              const SizedBox(width: 20),
              Text(translations.translate('Dodaj alarm')),
            ],
          ),
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Container(
          color: Theme.of(context).primaryColor,
          width: 60,
          height: 60,
          child: const Icon(Icons.more_vert, color: Colors.white),
        ),
      ),
    );
  }
}
