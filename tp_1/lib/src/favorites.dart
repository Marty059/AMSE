import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/main.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty &&
        appState.titleFavoritesFilm.isEmpty &&
        appState.titleFavoritesSeries.isEmpty &&
        appState.titleFavoritesLivres.isEmpty) {
      return Center(
        child: Text("No favourites yet"),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
              'Vous avez ${appState.favorites.length + appState.titleFavoritesFilm.length + appState.titleFavoritesSeries.length + appState.titleFavoritesLivres.length} favoris:'),
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
        for (var titre in appState.titleFavoritesFilm)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Film : $titre",
            ),
          ),
        SizedBox(width: 10),
        Divider(),
        SizedBox(width: 10),
        for (var titre in appState.titleFavoritesSeries)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Série : $titre",
            ),
          ),
        SizedBox(width: 10),
        Divider(),
        SizedBox(width: 10),
        for (var titre in appState.titleFavoritesLivres)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Livres : $titre",
            ),
          ),
      ],
    );
  }
}
