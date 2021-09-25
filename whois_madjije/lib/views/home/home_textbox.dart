import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class HomeTextbox extends StatelessWidget {
  const HomeTextbox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Material(
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                  left: 25, bottom: 25, top: 25, right: 85),
              hintText: translations.translate('Unesite ime domena'),
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -2,
            child: ElevatedButton(
              onPressed: () => {},
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              style: _buttonStyle(),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.only(bottom: 25, top: 20),
      ),
    );
  }
}
