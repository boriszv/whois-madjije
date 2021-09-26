import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/app_localizations.dart';
import 'package:whois_madjije/services/isettings_service.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final settingsService = GetIt.I<ISettingsService>();

  String? language;
  NotificationSettings? notificationSettings;

  @override
  void initState() {
    super.initState();

    settingsService.getLanguage().then((value) {
      setState(() {
        language = value;
      });
    });

    settingsService.getNotificationSettings().then((value) {
      setState(() {
        notificationSettings = value;
      });
    });
  }

  void _updateLanguage(String language) async {
    await settingsService.setLanguage(language);
    setState(() {
      this.language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: Text(translations.translate('Podesavanja')),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _Card(
            title: 'Lokalizacija',
            icon: Icons.translate,
            child: Column(
              children: [
                _Radio(
                  groupValue: language,
                  onChange: _updateLanguage,
                  value: 'sr',
                  label: translations.translate('Cirilica'),
                ),
                _Radio(
                  groupValue: language,
                  onChange: _updateLanguage,
                  value: 'sr-sp',
                  label: translations.translate('Latinica'),
                ),
              ],
            ),
          ),
          _Card(
            title: 'Obavestenja',
            icon: Icons.notifications,
            child: Container(),
          ),
          // _Card(
          //   title: 'Tamni mod',
          //   icon: Icons.brightness_6,
          //   child: Container(),
          // ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {

  final IconData icon;
  final String title;
  final Widget child;

  const _Card({Key? key, 
    required this.title, 
    required this.icon,
    required this.child,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset.fromDirection(-6, 4),
              blurRadius: 4,
              color: const Color.fromRGBO(0, 0, 0, 0.15),
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Theme.of(context).primaryColor,
                    size: 28,),

                  const SizedBox(width: 15),

                  Text(translations.translate(title), style: Theme.of(context).textTheme.headline5?.apply(
                    fontWeightDelta: 1,
                    fontSizeDelta: -2
                  )),
                ],
              ),

              const Divider(
                color: Colors.black54,
              ),

              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _Radio extends StatelessWidget {

  final String label;
  final String? groupValue;
  final String value;
  final Function onChange;

  const _Radio({Key? key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      contentPadding: const EdgeInsets.all(0),
      leading: Radio(  
        value: value,
        groupValue: groupValue,
        onChanged: (value) {  
          onChange(value);
        },
      ),  
      onTap: () {
        onChange(value);
      },
    );
  }
}
