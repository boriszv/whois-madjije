import 'package:flutter/material.dart';

import '../search_textbox.dart';

class DomainDetail extends StatelessWidget {
  DomainDetail({Key? key}) : super(key: key);
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
