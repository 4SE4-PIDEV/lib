import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product_info.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<GameData> _games = [];

  final String _baseUrl = "10.0.2.2:9090";

  late Future<bool> fetchedGames;

  Future<bool> fetchGames() async {
    http.Response response = await http.get(Uri.http(_baseUrl, "/game"));

    List<dynamic> gamesFromServer = json.decode(response.body);
    for(int i = 0; i < gamesFromServer.length; i++) {
      _games.add(GameData(gamesFromServer[i]["_id"], gamesFromServer[i]["title"], gamesFromServer[i]["image"],  gamesFromServer[i]["description"],
          int.parse(gamesFromServer[i]["price"].toString()), int.parse(gamesFromServer[i]["quantity"].toString())));
    }

    return true;
  }

  @override
  void initState() {
    fetchedGames = fetchGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedGames,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: _games.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductInfo(_games[index].id, _games[index].image, _games[index].title, _games[index].description,
                  _games[index].price, _games[index].quantity);
            },
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}

class GameData {
  final String id;
  final String title;
  final String image;
  final String description;
  final int price;
  final int quantity;

  GameData(this.id, this.title, this.image, this.description, this.price,
      this.quantity);

  @override
  String toString() {
    return 'GameData{id: $id, title: $title, image: $image, description: $description, price: $price, quantity: $quantity}';
  }
}