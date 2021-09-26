import 'package:flutter/material.dart';
import 'package:whois_madjije/app_localizations.dart';

class YesNoDialog extends StatefulWidget {
  final String text;
  final Function onProceed;

  const YesNoDialog({
    Key? key,
    required this.text,
    required this.onProceed,
  }) : super(key: key);

  @override
  State<YesNoDialog> createState() => _YesNoDialogState();
}

class _YesNoDialogState extends State<YesNoDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(translations.translate('Da li ste sigurni?')),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    size: 90,
                  )
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
            widget.onProceed();
            Navigator.of(context).pop();
          },
          child: Text(
            translations.translate('Nastavi'),
          ),
        ),
      ],
    );
  }
}
