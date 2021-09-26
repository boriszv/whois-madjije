import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:whois_madjije/app_localizations.dart';
import 'package:whois_madjije/services/ifavorites_service.dart';
import 'package:whois_madjije/services/inotifications_service.dart';
import 'package:whois_madjije/services/isettings_service.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whois_madjije/views/sharedWidgets/no_data_widget.dart';
import 'package:open_file/open_file.dart';

class DomainDetail extends StatefulWidget {
  final String domain;

  const DomainDetail({Key? key, required this.domain}) : super(key: key);

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

    setState(() {
      loading = true;
    });

    Future.wait([
      notificationsService.getNotification(widget.domain).then((value) {
        setState(() {
          hasNotification = value != null;
        });
      }),
      favoritesService.getFavorite(widget.domain).then((value) {
        setState(() {
          isInFavorites = value != null;
        });
      }),
      whoisDataService.getWhoisData(widget.domain).then((value) {
        setState(() {
          data = value;
          _setUpVisiblity();
        });
      }),
    ]).then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> _favoriteClicked() async {
    String message;

    if (isInFavorites) {
      await favoritesService.removeFromFavorites(widget.domain);

      if (hasNotification) {
        await notificationsService.cancelNotification(widget.domain);
        setState(() {
          hasNotification = false;
        });
      }

      setState(() {
        isInFavorites = false;
      });
      message = 'Izbrisano iz omiljenog';
    } else {
      await favoritesService.addFavorite(Favorite(
        dateTime: DateTime.now(),
        domainName: widget.domain,
        registered: data?.exists ?? false,
      ));
      message = 'Dodato u omiljene';

      setState(() {
        isInFavorites = true;
      });
    }

    _showToast(message);
  }

  Future<void> _notificationClicked() async {
    String message;

    if (hasNotification) {
      await notificationsService.cancelNotification(widget.domain);

      message = 'Podsetnik je otkazan';
      setState(() {
        hasNotification = false;
      });
    } else {
      final notificationSettings =
          await settingsService.getNotificationSettings();

      var dateTime = DateTime.tryParse(data?.expiresDate ?? '');
      dateTime ??= await _showDatePicker();

      if (dateTime == null) {
        return;
      }

      await notificationsService.addNotification(WhoisNotification(
          deviceToken: (await FirebaseMessaging.instance.getToken())!,
          domain: widget.domain,
          expirationDateTime: dateTime.toIso8601String(),
          status: 'queued',
          type: notificationSettings.type == NotificationType.push
              ? 'push'
              : 'email'));

      if (!isInFavorites) {
        await favoritesService.addFavorite(Favorite(
          dateTime: DateTime.now(),
          domainName: widget.domain,
          registered: data?.exists ?? false,
        ));

        setState(() {
          isInFavorites = true;
        });
      }

      setState(() {
        hasNotification = true;
      });

      message = 'Podsetnik je dodat';
    }

    _showToast(message);
  }

  Future<DateTime?> _showDatePicker() async {
    final translations = AppLocalizations.of(context);

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(translations.translate('Unesite datum')),
              content: Text(translations.translate(
                  'Nismo mogli da pronadjemo datum isteka za ovaj domen. Molim vas unesite datum kada zelite da budete obavesteni')),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                )
              ],
            ));

    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
  }

  void _setUpVisiblity() {
    showGeneralInfo = _determineVisiblity([
      data?.domainName,
      data?.createdDate,
      data?.updatedDate,
      data?.expiresDate,
    ]);

    showRegistrant = _determineVisiblity([
      data?.registrantOrganization,
      data?.registrantState,
      data?.registrantCountry,
      data?.registrantCountryCode,
    ]);

    showAdministrativeContact = _determineVisiblity([
      data?.administrativeContactOrganization,
      data?.administrativeContactState,
      data?.administrativeContactCountry,
      data?.administrativeContactCountryCode,
    ]);

    showTechnicalContact = _determineVisiblity([
      data?.technicalContactOrganization,
      data?.technicalContactState,
      data?.technicalContactCountry,
      data?.technicalContactCountryCode,
    ]);

    showRegistrar = _determineVisiblity([
      data?.registrarName,
      data?.registrarIANAID,
    ]);

    showNameservers = data!.nameServers.isNotEmpty;
    showIps = data!.ips.isNotEmpty;
  }

  bool _determineVisiblity(List<String?> values) {
    return values.any((element) => element != null && element.isNotEmpty);
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  var showGeneralInfo = true;
  var showRegistrant = true;
  var showAdministrativeContact = true;
  var showTechnicalContact = true;
  var showRegistrar = true;
  var showNameservers = true;
  var showIps = true;

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          title: Text(translations.translate('Podaci o domenu')),
        ),
        floatingActionButton: !loading && data?.exists == true
            ? _FloatingButton(
                hasNotification: hasNotification,
                isInFavorites: isInFavorites,
                data: data!,
                favoriteClicked: () {
                  _favoriteClicked();
                },
                notificationClicked: () {
                  _notificationClicked();
                },
              )
            : null,
        body: Builder(
          builder: (context) {
            if (loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (data?.exists == false) {
              return NoDataWidget(
                text: translations.translate('Ovaj domen nije registrovan'),
                icon: Icons.language,
              );
            }

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 10),
                if (showGeneralInfo)
                  _Card(
                    title: 'General info',
                    data: [
                      {
                        'key': 'Domain',
                        'value': data?.domainName,
                      },
                      {
                        'key': 'Created date',
                        'value': data?.createdDate,
                      },
                      {
                        'key': 'Updated date',
                        'value': data?.updatedDate,
                      },
                      {
                        'key': 'Expires date',
                        'value': data?.expiresDate,
                      },
                    ],
                  ),
                if (showRegistrant)
                  _Card(
                    title: 'Registrant',
                    data: [
                      {
                        'key': 'Organization',
                        'value': data?.registrantOrganization,
                      },
                      {
                        'key': 'State',
                        'value': data?.registrantState,
                      },
                      {
                        'key': 'Country',
                        'value': data?.registrantCountry,
                      },
                      {
                        'key': 'Country code',
                        'value': data?.registrantCountryCode,
                      },
                    ],
                  ),
                if (showAdministrativeContact)
                  _Card(
                    title: 'Administrative contact',
                    data: [
                      {
                        'key': 'Organization',
                        'value': data?.administrativeContactOrganization,
                      },
                      {
                        'key': 'State',
                        'value': data?.administrativeContactState,
                      },
                      {
                        'key': 'Country',
                        'value': data?.administrativeContactCountry,
                      },
                      {
                        'key': 'Country code',
                        'value': data?.administrativeContactCountryCode,
                      },
                    ],
                  ),
                if (showTechnicalContact)
                  _Card(
                    title: 'Technical contact',
                    data: [
                      {
                        'key': 'Organization',
                        'value': data?.technicalContactOrganization,
                      },
                      {
                        'key': 'State',
                        'value': data?.technicalContactState,
                      },
                      {
                        'key': 'Country',
                        'value': data?.technicalContactCountry,
                      },
                      {
                        'key': 'Country code',
                        'value': data?.technicalContactCountryCode,
                      },
                    ],
                  ),
                if (showRegistrar)
                  _Card(
                    title: 'Registrar',
                    data: [
                      {'key': 'Registrar Name', 'value': data?.registrarName},
                      {
                        'key': 'Registrar IANAID',
                        'value': data?.registrarIANAID
                      },
                    ],
                  ),
                if (showNameservers)
                  _Card(
                    title: 'Nameservers',
                    data: data?.nameServers
                            .map((e) => {'key': '', 'value': e})
                            .toList() ??
                        [],
                  ),
                if (showIps)
                  _Card(
                    title: 'Ip adrese',
                    data: data?.ips
                            .map((e) => {'key': '', 'value': e})
                            .toList() ??
                        [],
                  ),
                const SizedBox(height: 20),
              ],
            );
          },
        ));
  }
}

class _FloatingButton extends StatelessWidget {
  final bool hasNotification;
  final bool isInFavorites;

  final WhoisData? data;

  final Function favoriteClicked;
  final Function notificationClicked;

  const _FloatingButton(
      {required this.hasNotification,
      required this.isInFavorites,
      required this.favoriteClicked,
      required this.notificationClicked,
      required this.data});

  void _exportAsPDF() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        }));

    var tmpDir = await getTemporaryDirectory();

    final file = File("${tmpDir.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);

    Fluttertoast.showToast(
        msg: 'Done',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    final favoriteIcon = isInFavorites ? Icons.star : Icons.star_border;

    final favoriteText =
        isInFavorites ? 'Izbrisi iz omiljenog' : 'Dodaj u omiljeno';

    final notificationIcon =
        hasNotification ? Icons.notifications : Icons.notifications_none;

    final notificationText =
        hasNotification ? 'Obrisi podsetnik' : 'Dodaj podsetnik';

    return SpeedDial(
      child: const Icon(Icons.more_vert, color: Colors.white),
      // backgroundColor: Colors.black,
      overlayColor: Colors.grey,
      children: [
        SpeedDialChild(
            child:
                Icon(notificationIcon, color: Theme.of(context).primaryColor),
            label: translations.translate(notificationText),
            onTap: () {
              notificationClicked();
            }),
        SpeedDialChild(
            child: Icon(favoriteIcon, color: Theme.of(context).primaryColor),
            label: translations.translate(favoriteText),
            onTap: () {
              favoriteClicked();
            }),
        if (data == null)
          SpeedDialChild(
              child: Icon(Icons.share, color: Theme.of(context).primaryColor),
              label: translations.translate('Podeli'),
              onTap: () {}),
        if (data == null)
          SpeedDialChild(
              child: Icon(Icons.picture_as_pdf,
                  color: Theme.of(context).primaryColor),
              label: translations.translate('Generisi PDF'),
              onTap: () {
                _exportAsPDF();
              }),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final List<Map<String, String?>> data;

  const _Card({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset.fromDirection(-6, 4),
              blurRadius: 4,
              color: const Color.fromRGBO(0, 0, 0, 0.15),
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.headline5?.apply(
                      color: Theme.of(context).primaryColor,
                      fontWeightDelta: 2,
                      fontSizeDelta: -2)),
              const SizedBox(height: 5),
              ...data.map((e) {
                var key = e['key'];
                final value = e['value'];

                if (key?.isNotEmpty == true) {
                  key = key! + ': ';
                }

                if (value == null) {
                  return Container();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RichText(
                      text: TextSpan(
                        text: key,
                        style: Theme.of(context).textTheme.subtitle1?.apply(
                            color: Theme.of(context).primaryColor,
                            fontWeightDelta: 1),
                        children: [
                          TextSpan(
                              text: value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.apply(fontWeightDelta: -1)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
