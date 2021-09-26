import 'package:flutter/material.dart';
import 'package:whois_madjije/views/favorites/favorites_view.dart';
import 'package:whois_madjije/views/history/history_view.dart';
import 'package:whois_madjije/views/settings/settings.dart';

import '../app_localizations.dart';
import 'home/home_view.dart';

class NavConstants {
  static const HOME = 0;
  static const FAVORITES = 1;
  static const HISTORY = 2;
  static const SETTINGS = 3;
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final navigatorKeys = <GlobalKey<NavigatorState>>[
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  int _index = 0;

  setPageIndex(int i) {
    setState(() {
      _index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        backgroundColor:
            _index == 0 ? const Color.fromARGB(255, 22, 93, 187) : null,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset.fromDirection(-5, 4),
                blurRadius: 10,
                color: const Color.fromRGBO(0, 0, 0, 0.25),
                spreadRadius: 4,
              )
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            currentIndex: _index,
            onTap: setPageIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey.shade400,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home, size: 30),
                label: translations.translate('Pocetna'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star, size: 30),
                label: translations.translate('Omiljeno'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.history, size: 30),
                label: translations.translate('Istorija'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings, size: 30),
                label: translations.translate('Podesavanja'),
              ),
            ],
            backgroundColor: Colors.white,
          ),
        ),
        body: IndexedStack(
          children: <Widget>[
            Navigator(
              key: navigatorKeys[NavConstants.HOME],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) {
                    return HomeView();
                  },
                );
              },
            ),
            Navigator(
              key: navigatorKeys[NavConstants.FAVORITES],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) {
                    return const FavoritesView();
                  },
                );
              },
            ),
            Navigator(
              key: navigatorKeys[NavConstants.HISTORY],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) {
                    return const HistoryView();
                  },
                );
              },
            ),
            Navigator(
              key: navigatorKeys[NavConstants.SETTINGS],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) {
                    return Settings();
                  },
                );
              },
            ),
          ],
          index: _index,
        ),
      ),
    );
  }
}
