import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
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
            Material(
              elevation: 5.0,
              // borderRadius: const BorderRadius.only(
              //   topRight: Radius.circular(25),
              //   topLeft: Radius.circular(25),
              //   bottomRight: Radius.circular(25),
              //   bottomLeft: Radius.circular(25),
              // ),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Type in a domain name',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  suffixIcon: Material(
                    color: Theme.of(context).primaryColor,
                    child: const Icon(Icons.chevron_right, color: Colors.white),
                    shadowColor: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        // topRight: Radius.circular(25),
                        // bottomRight: Radius.circular(25),
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 130,
              child: TextButton(
                onPressed: () => {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.search),
                    SizedBox(width: 5),
                    Text('Search')
                  ],
                ),
                style: ButtonStyle(
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
