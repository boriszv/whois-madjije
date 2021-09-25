import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';

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
        title: const Text('Domain List'),
      ),
      body: ListView.builder(
        itemCount: domainAvailabilityList.length + 1,
        itemBuilder: (context, itemIndex) {
          return itemIndex < domainAvailabilityList.length
              ? Text(domainAvailabilityList[itemIndex].domainName)
              : isLoading
                  ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox();
        },
      ),
      // isLoading ? const CircularProgressIndicator() : Container()
    );
  }
}
