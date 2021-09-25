import 'package:flutter/material.dart';

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

    return Scaffold(
      body: WillPopScope(
        onWillPop: null,
        child: Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
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
                      return Scaffold(body: Text('as2'));
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
                      return Scaffold(body: Text('as3'));
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
                      return Scaffold(body: Text('as4'));
                    },
                  );
                },
              ),
            ],
            index: _index,
          ),
        ),
      ),
    );
  }
}
