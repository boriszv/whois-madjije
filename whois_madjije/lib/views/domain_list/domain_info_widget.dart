import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class DomainInfo extends StatelessWidget {
  final String domainName;
  final bool isRegistered;
  final IconData icon;
  final Color iconColor;
  final Function onCardPressed;
  final Function? iconOnPressed;
  final DateTime? date;
  final bool? isHistoryIconShown;

  const DomainInfo({
    Key? key,
    required this.domainName,
    required this.isRegistered,
    required this.icon,
    required this.iconColor,
    required this.onCardPressed,
    this.iconOnPressed,
    this.date,
    this.isHistoryIconShown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: InkWell(
        onTap: () {
          onCardPressed();
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
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
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            domainName,
                            style: const TextStyle(fontSize: 22),
                            maxLines: 2,
                          ),
                        ),
                        if (date != null)
                          Column(
                            children: [
                              const SizedBox(height: 8),
                              _showIconWithText(
                                Icons.event,
                                Theme.of(context).primaryColor,
                                'Pre 2 minuta',
                              ),
                            ],
                          ),
                        const SizedBox(height: 8),
                        if (isRegistered)
                          _showIconWithText(
                            Icons.check,
                            const Color.fromRGBO(56, 214, 0, 1),
                            translations.translate('Registrovan'),
                          )
                        else
                          _showIconWithText(
                            Icons.clear,
                            const Color.fromRGBO(214, 64, 0, 1),
                            translations.translate('Nije Registrovan'),
                          )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (iconOnPressed != null) iconOnPressed!();
                      },
                      icon: Icon(
                        icon,
                        size: 32,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),

                // HISTORY ICON
                if (isHistoryIconShown != null && isHistoryIconShown == true)
                  Positioned(
                    right: 45,
                    bottom: 7,
                    child: Icon(
                      Icons.history,
                      size: 65,
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _showIconWithText(IconData icon, Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
