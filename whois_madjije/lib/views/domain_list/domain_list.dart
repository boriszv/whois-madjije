import 'package:flutter/material.dart';

class DomainList extends StatelessWidget {
  DomainList({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        title: const Text('Domain List'),
      ),
    );
  }
}
