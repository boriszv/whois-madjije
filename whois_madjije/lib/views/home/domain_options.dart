import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whois_madjije/app_localizations.dart';
import 'package:whois_madjije/hardcoded_domains.dart';
import 'package:whois_madjije/services/isettings_service.dart';

class DomainOptions extends StatefulWidget {

  @override
  State<DomainOptions> createState() => _DomainOptionsState();
}

class _DomainOptionsState extends State<DomainOptions> {

  List<String> savedDomains = [];

  List<String> filteredDomains = hardcodedDomains;

  final ISettingsService _settings = GetIt.I<ISettingsService>();

  final searchOnChange = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    _settings.getSavedDomainsList().then((value) {
      setState(() {
        savedDomains = value;
      });
    });

    searchOnChange.debounceTime(Duration(milliseconds: 500)).listen((text) {
      setState(() {
        filteredDomains = hardcodedDomains.where((x) => x.contains(text)).toList();
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
        title: Text(translations.translate('Opcije')),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: translations.translate('Pretrazi domene'),
                      prefixIcon: const Icon(Icons.search)
                    ),
                    onChanged: (text) {
                      searchOnChange.add(text);
                    },
                  ),
                ),

                const SizedBox(height: 10),

                _ChipList(
                  domains: savedDomains,
                  onRemoved: (domain) async {
                    setState(() {
                      savedDomains = savedDomains.where((x) => x != domain).toList();
                    });
                    await _settings.updateSavedDomains(savedDomains);
                  }
                ),

                _ListView(
                  filteredDomains: filteredDomains,
                  selectedDomains: savedDomains,
                  onSelect: (e) async {
                    setState(() {
                      savedDomains.add(e);
                    });
                    await _settings.updateSavedDomains(savedDomains);
                  },
                  onRemove: (e) async {
                    setState(() {
                      savedDomains = savedDomains.where((x) => x != e).toList();
                    });
                    await _settings.updateSavedDomains(savedDomains);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _ChipList extends StatelessWidget {

  final List<String> domains;
  final Function onRemoved;

  const _ChipList({Key? key, required this.domains, required this.onRemoved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: domains.map((e) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Chip(
            label: Text(e, style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
            )),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () {
              onRemoved(e);
            },
            backgroundColor: Theme.of(context).primaryColor,
            deleteIconColor: Colors.white
          ),
        );
      }).toList(),
    );
  }
}

class _ListView extends StatelessWidget {

  final List<String> filteredDomains;
  final List<String> selectedDomains;

  final Function onSelect;
  final Function onRemove;

  _ListView({
    required this.filteredDomains,
    required this.selectedDomains,

    required this.onSelect,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filteredDomains.map((e) {
          final isSelected = selectedDomains.contains(e);

          return ListTile(
            title: Text(e),
            trailing: isSelected ? Icon(Icons.check) : null,
            onTap: () {
              if (isSelected) {
                onRemove(e);

              } else {
                onSelect(e);
              }
            },
          );

        }).toList(),
      ),
    );
  }
}
