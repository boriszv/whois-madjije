import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('sr'),
        const Locale('sr-sp'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // for (final item in supportedLocales) {
        //   if (item.languageCode == locale.languageCode) {
        //     return item;
        //   }
        // }

        return supportedLocales.first;
      },
      home: const Home(),
    );
  }
}

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
