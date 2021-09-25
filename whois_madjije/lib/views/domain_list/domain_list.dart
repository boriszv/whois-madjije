import 'package:flutter/material.dart';
import 'package:whois_madjije/views/search_textbox.dart';

class DomainList extends StatelessWidget {
  DomainList({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchTextbox(
              controller: controller,
              onSubmit: () => {},
            ),
            const Icon(
              Icons.list,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
