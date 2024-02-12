import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/main.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty && appState.titleFavorites.isEmpty) {
      return Center(
        child: Text("No favourites yet"),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
              'Vous avez ${appState.favorites.length + appState.titleFavorites.length} favoris:'),
        ),
        SizedBox(width: 10),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
        SizedBox(width: 10),
        Divider(),
        SizedBox(width: 10),
        for (var titre in appState.titleFavorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Film : $titre",
            ),
          ),
        SizedBox(width: 10),
      ],
    );
  }
}
