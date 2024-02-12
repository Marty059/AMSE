import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/src/books.dart';
import 'package:tp_1/src/favorites.dart';
import 'package:tp_1/src/films.dart';
import 'package:tp_1/src/home.dart';
import 'package:tp_1/src/series.dart';

// Bonjour Monsieur !
// Notre applications permet de se balader entre 5 pages :
// La page d'accueil, Les favoris, Les Livres, Les films et Les séries
// Vous pouvez mettre en favoris des livres/films/séries. (Le deuxième livre vous plaira beaucoup).
// Chaque page est dans un fichier distinct.
// Les modèles de présentation sont aussi dans un fichier distinct.
// Bonne appréciation !

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Géry et Martin app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 14, 81, 227)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var titleFavoritesFilm = <String>[];
  var titleFavoritesSeries = <String>[];
  var titleFavoritesLivres = <String>[];

  void toggleFavoriteTitleFilm(titre) {
    if (titleFavoritesFilm.contains(titre)) {
      titleFavoritesFilm.remove(titre);
    } else {
      titleFavoritesFilm.add(titre);
    }
    notifyListeners();
  }

  void toggleFavoriteTitleSeries(titre) {
    if (titleFavoritesSeries.contains(titre)) {
      titleFavoritesSeries.remove(titre);
    } else {
      titleFavoritesSeries.add(titre);
    }
    notifyListeners();
  }

  void toggleFavoriteTitleLivres(titre) {
    if (titleFavoritesLivres.contains(titre)) {
      titleFavoritesLivres.remove(titre);
    } else {
      titleFavoritesLivres.add(titre);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = BooksPage();
        break;
      case 3:
        page = FilmsPage();
        break;
      case 4:
        page = SeriePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Maison',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favoris',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Livres',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Films',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: 'Séries',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              selectedItemColor: Theme.of(context)
                  .colorScheme
                  .primary, // Couleur des éléments sélectionnés
              unselectedItemColor: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
