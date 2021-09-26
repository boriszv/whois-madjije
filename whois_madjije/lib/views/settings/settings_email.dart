import 'package:flutter/material.dart';
import 'package:whois_madjije/app_localizations.dart';

class SettingsEmail extends StatefulWidget {
  final String? email;

  const SettingsEmail({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<SettingsEmail> createState() => _SettingsEmailState();
}

class _SettingsEmailState extends State<SettingsEmail> {
  @override
  void initState() {
    _controller.text = widget.email ?? '';
    super.initState();
  }

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(translations.translate('Unesite email')),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: TextField(
                  autofocus: true,
                  controller: _controller,
                  decoration:
                      const InputDecoration(hintText: 'something@example.com'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person,
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      size: 90)
                ],
              )
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            translations.translate('Otkazi'),
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
          child: Text(
            translations.translate('Sacuvaj'),
          ),
        ),
      ],
    );
  }
}
