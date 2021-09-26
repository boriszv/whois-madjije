import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whois_madjije/app_localizations.dart';
import 'package:whois_madjije/services/isettings_service.dart';
import 'package:whois_madjije/views/settings/settings_email.dart';

class SelectNotificationType extends StatefulWidget {
  @override
  State<SelectNotificationType> createState() => _SelectNotificationTypeState();
}

class _SelectNotificationTypeState extends State<SelectNotificationType> {
  final settingsService = GetIt.I<ISettingsService>();

  NotificationType notificationType = NotificationType.push;
  NotificationSettings? notificationSettings;

  @override
  void initState() {
    super.initState();
    settingsService.getNotificationSettings().then((value) {
      setState(() {
        notificationSettings = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return AlertDialog(
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () async {
            if ((notificationSettings?.email == null ||
                    notificationSettings?.email == '') &&
                notificationType == NotificationType.email) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [Text('Morate uneti email adresu')],
                  ),
                ),
              );

              return;
            }
            Navigator.of(context).pop(notificationType);
          },
        ),
      ],
      actionsPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              const SizedBox(width: 15),
              Text(translations.translate('Obavestenja'),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.apply(fontWeightDelta: 1, fontSizeDelta: -2)),
            ],
          ),
          const SizedBox(height: 15),
          ListTile(
            title: const Text('Email'),
            subtitle: notificationSettings?.email != null
                ? Text(notificationSettings!.email!)
                : null,
            contentPadding: const EdgeInsets.all(0),
            leading: Radio<NotificationType?>(
              value: NotificationType.email,
              groupValue: notificationType,
              onChanged: (value) {
                setState(() {
                  notificationType = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                notificationType = NotificationType.email;
              });
            },
            trailing: notificationType == NotificationType.email
                ? IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 19,
                    ),
                    onPressed: () async {
                      final email = await showDialog(
                        context: context,
                        builder: (_) => SettingsEmail(
                          email: notificationSettings?.email,
                        ),
                      );
                      if (email == null || email == '') {
                        return;
                      }

                      notificationSettings ??=
                          NotificationSettings(type: NotificationType.push);
                      notificationSettings!.email = email;

                      await settingsService
                          .setNotificationSettings(notificationSettings!);

                      setState(() {
                        notificationSettings!.email = email;
                      });
                    },
                  )
                : null,
          ),
          ListTile(
            title: const Text('Push'),
            // subtitle: Text('guwop@atlantic.com'),
            contentPadding: const EdgeInsets.all(0),
            leading: Radio<NotificationType?>(
              value: NotificationType.push,
              groupValue: notificationType,
              onChanged: (value) {
                setState(() {
                  notificationType = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                notificationType = NotificationType.push;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _Card({
    Key? key,
    required this.title,
    required this.icon,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 10),
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
              Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 15),
                  Text(translations.translate(title),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.apply(fontWeightDelta: 1, fontSizeDelta: -2)),
                ],
              ),
              const Divider(
                color: Colors.black54,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
