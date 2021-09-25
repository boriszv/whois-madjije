import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';

import 'registration_status.dart';

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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: const Text('Domeni'),
        elevation: 3,
      ),
      body: ListView.builder(
        itemCount: domainAvailabilityList.length + 1,
        itemBuilder: (context, itemIndex) {
          return itemIndex < domainAvailabilityList.length
              ? RegistrationStatus(
                  domainAvailability: domainAvailabilityList[itemIndex],
                )
              : isLoading
                  ? const SizedBox(
                      child: CircularProgressIndicator(),
                      height: 50,
                      width: 50,
                    )
                  : const SizedBox(height: 20);
        },
      ),
    );
  }
}
