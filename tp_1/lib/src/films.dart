import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/main.dart';
import 'package:tp_1/models.dart';

class FilmsPage extends StatelessWidget {
  const FilmsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView.builder(
      itemCount: films.length,
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
                      films[index].imageUrl,
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
                          films[index].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Réalisateur : ${films[index].realisateur}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: appState.titleFavoritesFilm.contains(films[index].title)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    appState.toggleFavoriteTitleFilm(films[index].title);
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
