import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'my_game_info.dart';
import '../home/home.dart';

class MyGames extends StatefulWidget {
  const MyGames({Key? key}) : super(key: key);

  @override
  State<MyGames> createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  final List<GameData> _games = [];

  final String _baseUrl = "10.0.2.2:9090";

  late Future<bool> _fetchedGames;

  Future<bool> fetchGames() async {
    http.Response response = await http.get(Uri.http(_baseUrl, "/library/" + "616d75ced2391777c9be4cad"));

    List<dynamic> gamesFromServer = json.decode(response.body);

    for(int i = 0; i < gamesFromServer.length; i++) {
      Map<String, dynamic> gameFromServer = gamesFromServer[i];
      _games.add(GameData(gameFromServer["_id"], gameFromServer["title"], gameFromServer["image"],
          gameFromServer["description"], int.parse(gameFromServer["price"].toString()),
          int.parse(gameFromServer["quantity"].toString())));
    }

    return true;
  }

  @override
  void initState() {
    _fetchedGames = fetchGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchedGames,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          return GridView.builder(
            itemCount: _games.length,
            itemBuilder: (BuildContext context, int index) {
              return MyGameInfo(_games[index].image, _games[index].title);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 120,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5
            ),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
