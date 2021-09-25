import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/app_localizations.dart';
import 'package:whois_madjije/services/favorites_service.dart';
import 'package:whois_madjije/services/ifavorites_service.dart';
import 'package:whois_madjije/services/inotifications_service.dart';
import 'package:whois_madjije/services/isettings_service.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';
import 'package:whois_madjije/services/notifications_service.dart';
import 'package:whois_madjije/services/settings_service.dart';

class DomainDetail extends StatefulWidget {

  final String domain;

  const DomainDetail({Key? key,
    required this.domain}) : super(key: key);

  @override
  State<DomainDetail> createState() => _DomainDetailState();
}

class _DomainDetailState extends State<DomainDetail> {
  
  final whoisDataService = GetIt.I<IWhoisDataService>();

  final notificationsService = GetIt.I<INotificationsService>();
  final favoritesService = GetIt.I<IFavoritesService>();

  final settingsService = GetIt.I<ISettingsService>();

  var loading = false;

  var hasNotification = false;
  var isInFavorites = false;

  WhoisData? data;

  @override
  void initState() {
    super.initState();

    setState(() { loading = true; });

    Future.wait([
      notificationsService.getNotification(widget.domain),
      favoritesService.getFavorite(widget.domain),
      // whoisDataService.getWhoisData(widget.domain),  

    ]).then((results) {
      hasNotification = results[0] != null;
      isInFavorites = results[1] != null;
      
      // setState(() { data = results[2] as WhoisData; });
    });
  }

  Future<void> _favoriteClicked() async {
    String message;

    if (isInFavorites) {
      await favoritesService.removeFromFavorites(widget.domain);
      message = 'Obrisano iz omiljenih';

    } else {
      await favoritesService.addFavorite(Favorite(
        dateTime: DateTime.now(),
        domainName: widget.domain
      ));
      message = 'Dodato u omiljene';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _notificationClicked() async {
    String message;

    if (isInFavorites) {
      await notificationsService.cancelNotification(widget.domain);
      message = 'Podsetnik je otkazan';

    } else {
      final notificationSettings = await settingsService.getNotificationSettings();

      await notificationsService.addNotification(WhoisNotification(
        deviceToken: (await FirebaseMessaging.instance.getToken())!,
        domain: widget.domain,
        expirationDateTime: '',
        status: 'queued',
        type: notificationSettings.type == NotificationType.push
          ? 'push'
          : 'email'
      ));
      message = 'Podsetnik je dodat';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: const Text('Domain Detail'),
      ),
      floatingActionButton: _FloatingButton(
        hasNotification: hasNotification,
        isInFavorites: isInFavorites,
        favoriteClicked: () {
          _favoriteClicked();
        },
        notificationClicked: () {
          _notificationClicked();
        },
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {

  final bool hasNotification;
  final bool isInFavorites;

  final Function favoriteClicked;
  final Function notificationClicked;

  const _FloatingButton({
    required this.hasNotification,
    required this.isInFavorites,
    required this.favoriteClicked,
    required this.notificationClicked,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    final favoriteIcon = isInFavorites
      ? Icons.star
      : Icons.star_border;

    final favoriteText = isInFavorites
      ? 'Izbrisi iz omiljenog'
      : 'Dodaj u omiljeno';

    final notificationIcon = hasNotification
      ? Icons.notifications
      : Icons.notifications_none;

    final notificationText = hasNotification
      ? 'Obrisi podsetnik'
      : 'Dodaj podsetnik';

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          onTap: () {
            favoriteClicked();
          },
          child: Row(
            children: [
              Icon(favoriteIcon, color: Theme.of(context).primaryColor),
              const SizedBox(width: 20),
              Text(translations.translate(favoriteText)),
            ],
          ),
        ),
        PopupMenuItem<int>(
          onTap: () {
            notificationClicked();
          },
          child: Row(
            children: [
              Icon(notificationIcon, color: Theme.of(context).primaryColor),
              const SizedBox(width: 20),
              Text(translations.translate(notificationText)),
            ],
          ),
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Container(
          color: Theme.of(context).primaryColor,
          width: 60,
          height: 60,
          child: const Icon(Icons.more_vert, color: Colors.white),
        ),
      ),
    );
  }
}
