import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class DomainInfo extends StatefulWidget {
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
  State<DomainInfo> createState() => _DomainInfoState();
}

class _DomainInfoState extends State<DomainInfo> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

    subscription = Stream.periodic(const Duration(seconds: 59)).listen((event) {
      setState(() {
        // REBUILD
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: GestureDetector(
        onTap: () {
          widget.onCardPressed();
        },
        child: Container(
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
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Icon(
                  Icons.language,
                  color: Theme.of(context).primaryColor.withOpacity(0.07),
                  size: 650,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 15),
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
                                widget.domainName,
                                style: const TextStyle(fontSize: 22),
                                maxLines: 2,
                              ),
                            ),
                            if (widget.date != null)
                              Column(
                                children: [
                                  const SizedBox(height: 8),
                                  _showIconWithText(
                                    Icons.event,
                                    Theme.of(context).primaryColor,
                                    _getFormattedTime(
                                        widget.date!, translations),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 8),
                            if (widget.isRegistered)
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
                            if (widget.iconOnPressed != null) {
                              widget.iconOnPressed!();
                            }
                          },
                          icon: Icon(
                            widget.icon,
                            size: 32,
                            color: widget.iconColor,
                          ),
                        ),
                      ],
                    ),

                    // HISTORY ICON
                    if (widget.isHistoryIconShown != null &&
                        widget.isHistoryIconShown == true)
                      Positioned(
                        right: 45,
                        bottom: 12,
                        child: Icon(
                          Icons.history,
                          size: 65,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.15),
                        ),
                      )
                  ],
                ),
              )
            ],
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

  String _getFormattedTime(DateTime date, AppLocalizations translations) {
    var todaysDate = DateTime.now();

    Duration difference = todaysDate.difference(date);

    if (difference.inDays != 0) {
      var word = 'dan' + (difference.inDays > 1 ? 'a' : '');
      return '${translations.translate('Pre')} ${difference.inDays.toString()} ${translations.translate(word)}';
    } else if (difference.inHours != 0) {
      var char;
      if (difference.inHours == 1)
        char = '';
      else if (difference.inHours > 1 == difference.inHours <= 4)
        char = 'a';
      else
        char = 'i';

      return '${translations.translate('Pre')} ${difference.inHours.toString()} ${translations.translate('Sat' + char)}';
    } else if (difference.inMinutes != 0) {
      var word = 'minut' + (difference.inMinutes > 1 ? 'a' : '');
      return '${translations.translate('Pre')} ${difference.inMinutes.toString()} ${translations.translate(word)}';
    } else {
      return translations.translate('Pre par momenata');
    }
  }
}
