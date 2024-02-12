import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/src/books.dart';
import 'package:tp_1/src/favorites.dart';
import 'package:tp_1/src/films.dart';
import 'package:tp_1/src/generator.dart';
import 'package:tp_1/src/series.dart';

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
        title: 'Namer App',
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
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  var titleFavorites = <String>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void toggleFavoriteTitle(titre) {
    if (titleFavorites.contains(titre)) {
      titleFavorites.remove(titre);
    } else {
      titleFavorites.add(titre);
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
        page = GeneratorPage();
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

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase,
            style: style, semanticsLabel: "${pair.first} ${pair.second}"),
      ),
    );
  }
}
