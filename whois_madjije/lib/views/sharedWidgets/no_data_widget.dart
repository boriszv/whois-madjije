import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const NoDataWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 27),
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor.withOpacity(0.15),
              size: 300,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
