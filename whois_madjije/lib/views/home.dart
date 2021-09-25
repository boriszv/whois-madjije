import 'package:flutter/material.dart';
import 'package:whois_madjije/views/home_view.dart';

import '../app_localizations.dart';

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
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 13,
            unselectedFontSize: 13,
            currentIndex: _index,
            onTap: setPageIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.grey.shade400,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            backgroundColor: Colors.white,
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
