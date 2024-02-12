import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tp_1/main.dart';
import 'package:tp_1/models.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      books[index].imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          books[index].title,
                          style: TextStyle(
                            fontSize: 18, // Taille légèrement plus grande
                            fontWeight: FontWeight.bold, // Texte en gras
                          ),
                        ),
                        SizedBox(
                            height:
                                8), // Espace entre le titre et le réalisateur
                        Text(
                          'Auteur : ${books[index].realisateur}',
                          style: TextStyle(
                            fontSize: 16, // Taille normale pour le réalisateur
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon:
                      appState.titleFavoritesLivres.contains(books[index].title)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                  onPressed: () {
                    appState.toggleFavoriteTitleLivres(books[index].title);
                    // Action lorsque le bouton est pressé
                    // Vous pouvez mettre ici le code pour démarrer la lecture du film, par exemple
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
