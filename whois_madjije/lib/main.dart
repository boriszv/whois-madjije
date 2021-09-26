import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/di.dart';
import 'package:whois_madjije/services/isettings_service.dart';
import 'package:whois_madjije/views/nav_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app_localizations.dart';

void main() {
  setupDependencyInjection();
  runApp(Phoenix(
    child: App()
  ));
}
class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late Future<FirebaseApp> _initialization;

  final settingsService = GetIt.I<ISettingsService>();
  
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

        return FutureBuilder<String>(
          future: settingsService.getLanguage(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

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
                Locale('en'),
                Locale('sr'),
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (final item in supportedLocales) {
                  if (item.languageCode == snapshot.data) {
                    return item;
                  }
                }

                // if (locale?.languageCode == (snapshot.data ?? 'sr')) {
                //   return locale;
                // }
                return Locale(snapshot.data ?? 'en');
              },
              home: const Home(),
            );
          }
        );
      },
    );
  }
}