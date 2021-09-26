import 'package:flutter/material.dart';
import 'package:whois_madjije/views/domain_detail/domain_detail.dart';
import 'package:whois_madjije/views/domain_list/domain_list.dart';
import '../../app_localizations.dart';
import 'home_textbox.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = TextEditingController();

  onSearchClick(BuildContext context) {
    final translations = AppLocalizations.of(context);

    if (controller.text.isEmpty) {
      return;
    }

    if (controller.text.contains(' ')) {
      showDialog(context: context, builder: (builder) => AlertDialog(
        title: Text(translations.translate('Greska')),
        content: Text(translations.translate('Uneti domen nije ispravan')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(translations.translate('Ok')),
          )
        ],
      ));
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return controller.text.contains('.')
          ? DomainDetail(domain: controller.text)
          : DomainList(domain: controller.text);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/img/background.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'PRIORITY LOOKUP',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),

              // TEXTFIELD
              HomeTextbox(
                controller: controller,
                onSubmit: () {
                  onSearchClick(context);
                },
              ),

              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    onSearchClick(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 5),
                      Text(translations.translate('Pretrazi'))
                    ],
                  ),
                  style: _searchButtonStyle(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _searchButtonStyle(BuildContext context) {
    return ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor,
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
  }
}
