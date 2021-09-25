import 'package:flutter/material.dart';
import 'package:whois_madjije/services/iwhois_data_service.dart';

class RegistrationStatus extends StatelessWidget {
  final DomainAvailability domainAvailability;
  const RegistrationStatus({Key? key, required this.domainAvailability})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset.fromDirection(-6, 3),
              blurRadius: 4,
              color: const Color.fromRGBO(0, 0, 0, 0.15),
              spreadRadius: 2,
            )
          ],
        ),
        child: SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(domainAvailabilityList[0].domainName),
                    Text(
                      domainAvailability.domainName,
                      style: const TextStyle(fontSize: 22),
                    ),

                    const SizedBox(height: 5),

                    if (domainAvailability.isRegistered)
                      _getRegistrationInfoText(
                        Icons.check,
                        const Color.fromRGBO(56, 214, 0, 1),
                        'Registrovan',
                      )
                    else
                      _getRegistrationInfoText(
                        Icons.clear,
                        const Color.fromRGBO(214, 64, 0, 1),
                        'Nije Registrovan',
                      )
                  ],
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _getRegistrationInfoText(IconData icon, Color color, String text) {
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
