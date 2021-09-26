import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/ifavorites_service.dart';
import 'package:whois_madjije/views/domain_list/domain_info_widget.dart';
import 'package:whois_madjije/views/sharedWidgets/loading_widget.dart';

import '../../app_localizations.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final favoritesService = GetIt.I<IFavoritesService>();
  List<Favorite> favoriteList = [];

  var isLoading = true;

  @override
  void initState() {
    super.initState();

    favoritesService.getFavorites().then((result) {
      setState(() {
        favoriteList = result;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: Text(translations.translate('Omiljeno')),
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        itemCount: favoriteList.length + 1,
        itemBuilder: (context, itemIndex) {
          return itemIndex < favoriteList.length
              ? DomainInfo(
                  domainName: favoriteList[itemIndex].domainName,
                  isRegistered: favoriteList[itemIndex].registered,
                  icon: Icons.star,
                  iconColor: Colors.yellow,
                  date: favoriteList[itemIndex].dateTime,
                  onCardPressed: () {},
                  iconOnPressed: () {},
                )
              : LoadingIndicator(isLoading: isLoading);
        },
      ),
    );
  }
}
