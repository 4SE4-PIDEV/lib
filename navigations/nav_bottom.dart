import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../basket/basket.dart';
import '../home/home.dart';
import '../my_games/my_games.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  late int _currentIndex = 0;
  final List<Widget> _interfaces = const [Home(), MyGames(), Basket()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G-Store ESPRIT"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text("G-Store ESPRIT"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.edit),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Modifier profil")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/updateUser");
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.tab),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Navigation par anglets")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/navTab");
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.power_settings_new),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Se déconnecter")
                ],
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("userId");
                Navigator.pushReplacementNamed(context, "/");
              },
            )
          ],
        ),
      ),
      body: _interfaces[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Store"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.article),
            label : "Bibliothèque"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_rounded),
            label: "Panier"
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
