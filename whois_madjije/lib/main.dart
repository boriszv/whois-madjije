import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whois_madjije/di.dart';
import 'package:whois_madjije/views/nav_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app_localizations.dart';

void main() {
  setupDependencyInjection();
  runApp(App());
}
class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late Future<FirebaseApp> _initialization;

  
  @override
  void initState() {
    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            fontFamily: 'Poppins'
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
      },
    );
  }
}