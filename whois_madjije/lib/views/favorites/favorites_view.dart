import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get_it/get_it.dart';
import 'package:whois_madjije/services/ifavorites_service.dart';
import 'package:whois_madjije/views/domain_detail/domain_detail.dart';
import 'package:whois_madjije/views/domain_list/domain_info_widget.dart';
import 'package:whois_madjije/views/sharedWidgets/no_data_widget.dart';
import 'package:whois_madjije/views/sharedWidgets/yes_no_dialog.dart';

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

    favoritesService.updated$.listen((event) {
      _fetchFavorites();
    });

    _fetchFavorites();
  }

  void _fetchFavorites() {
    favoritesService.getFavorites().then((result) {
      setState(() {
        favoriteList = result;
        isLoading = false;
      });
    });
  }

  Future<void> _removeFromFavorites(
      String domain, AppLocalizations translations) async {
    await favoritesService.removeFromFavorites(domain);

    Fluttertoast.showToast(
      msg: translations.translate('Izbrisano iz omiljenog'),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.grey,
      fontSize: 16.0,
    );
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
      body: isLoading
          ? const CircularProgressIndicator()
          : favoriteList.isEmpty
              ? NoDataWidget(
                  text: translations.translate('Nema omiljenih domena'),
                  icon: Icons.star,
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: favoriteList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, itemIndex) {
                    return DomainInfo(
                      domainName: favoriteList[itemIndex].domainName,
                      isRegistered: favoriteList[itemIndex].registered,
                      icon: Icons.star,
                      iconColor: Colors.yellow[700]!,
                      date: favoriteList[itemIndex].dateTime,
                      onCardPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DomainDetail(
                                domain: favoriteList[itemIndex].domainName)));
                      },
                      iconOnPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => YesNoDialog(
                            text: translations.translate(
                                'Ova akcija ce obrisati selektovani domen iz omiljenih'),
                            onProceed: () {
                              _removeFromFavorites(
                                favoriteList[itemIndex].domainName,
                                translations,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
