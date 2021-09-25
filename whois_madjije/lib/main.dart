import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whois_madjije/di.dart';
import 'package:whois_madjije/views/nav_view.dart';

import 'app_localizations.dart';

void main() {
  setupDependencyInjection();
  runApp(const App());
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
         Locale('sr'),
         Locale('sr-sp'),
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