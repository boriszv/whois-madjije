import 'package:flutter/material.dart';

class DomainDetail extends StatelessWidget {
  const DomainDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: const Text('Domain Detail'),
      ),
    );
  }
}
