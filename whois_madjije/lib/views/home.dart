import 'package:flutter/material.dart';

import '../app_localizations.dart';


class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);
    return Scaffold(
      body: Center(child: Text(translations.translate('test'))),
    );
  }
}
