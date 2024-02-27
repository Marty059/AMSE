import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class Tile {
  String imageURL;
  Alignment alignment;
  int position_initiale;
  int position_actuelle;
  bool vide;

  Tile(
      {required this.imageURL,
      required this.alignment,
      required this.position_initiale,
      required this.position_actuelle,
      required this.vide});

  Widget croppedImageTile(double taille) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: taille,
            heightFactor: taille,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

class Exo7 extends StatefulWidget {
  @override
  _Exo7State createState() => _Exo7State();
}

class _Exo7State extends State<Exo7> {
  int taille_grille = 3;
  List<Tile> tiles = [];
  int deplacement = 0;
  Stopwatch _stopwatch = Stopwatch();
  String _elapsedTime = '';

  @override
  void initState() {
    super.initState();
    tiles = generateTiles();
    //_startTimer();
  }

  // Méthode pour démarrer le chronomètre
  void _startTimer() {
    _stopwatch.start();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = _stopwatch.elapsed.inSeconds.toString();
      });
    });
  }

  List<Tile> generateTiles() {
    List<Tile> tiles = [];
    int totalTiles = taille_grille * taille_grille;

    for (int i = 0; i < totalTiles; i++) {
      tiles.add(Tile(
        imageURL: 'https://picsum.photos/1024',
        alignment: calculateAlignment(i),
        position_initiale: i,
        position_actuelle: i,
        vide: false,
      ));
    }
    tiles[totalTiles - 1].vide = true;

    return tiles;
  }

  Alignment calculateAlignment(int position_initiale) {
    int row = position_initiale ~/ taille_grille;
    int column = position_initiale % taille_grille;

    double horizontalAlignment = (column / (taille_grille - 1)) * 2 - 1;
    double verticalAlignment = (row / (taille_grille - 1)) * 2 - 1;
    return Alignment(horizontalAlignment, verticalAlignment);
  }

  void moveTile(int position_actuelle) {
    if (!isValidMove(position_actuelle)) {
      return;
    }

    setState(() {
      int emptyTilePosition = tiles.indexWhere((tile) => tile.vide);
      Tile emptyTile = tiles[emptyTilePosition];
      Tile tileToSwap = tiles[position_actuelle];

      tiles[position_actuelle] = emptyTile;
      tiles[emptyTilePosition] = tileToSwap;

      emptyTile.position_actuelle = position_actuelle;
      tileToSwap.position_actuelle = emptyTilePosition;
      deplacement += 1;
      print(deplacement);
      // Démarrer le chronomètre si ce n'est pas déjà fait
      if (!_stopwatch.isRunning) {
        _startTimer();
      }
    });

    if (isSolved()) {
      // Arrêter le chronomètre lors de la victoire
      _stopwatch.stop();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Félicitations !'),
          content: Text(
              'Vous avez résolu le puzzle en $_elapsedTime secondes avec $deplacement coups !'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool isValidMove(int position_actuelle) {
    int emptyTilePosition = tiles.indexWhere((tile) => tile.vide);
    int emptyRow = emptyTilePosition ~/ taille_grille;
    int emptyColumn = emptyTilePosition % taille_grille;
    int targetRow = position_actuelle ~/ taille_grille;
    int targetColumn = position_actuelle % taille_grille;

    return (emptyRow == targetRow &&
            (emptyColumn - 1 == targetColumn ||
                emptyColumn + 1 == targetColumn)) ||
        (emptyColumn == targetColumn &&
            (emptyRow - 1 == targetRow || emptyRow + 1 == targetRow));
  }

  bool isSolved() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].position_initiale != i) {
        return false;
      }
    }
    return true;
  }

  void shuffleTiles() {
    setState(() {
      for (int i = tiles.length - 1; i > 0; i--) {
        int j = Random().nextInt(i + 1);
        Tile temp = tiles[i];
        tiles[i] = tiles[j];
        tiles[j] = temp;
      }
    });
  }

  void showFullImage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Aide : Image complète du Taquin'),
        content: Image.network('https://picsum.photos/1024'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            crossAxisCount: taille_grille,
            children: tiles.map((tile) {
              return createTileWidgetFrom(tile);
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Temps écoulé : $_elapsedTime secondes',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Text(
          'Déplacements : $deplacement',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            showFullImage();
          },
          child: Text('Afficher l\'image complète'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            shuffleTiles();
          },
          child: Text('Mélanger les tuiles'),
        ),
      ],
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    if (tile.vide) {
      return Opacity(
          opacity: 0.2,
          child: InkWell(
            child: tile.croppedImageTile(1 / taille_grille),
            onTap: () {},
          ));
    } else {
      return InkWell(
        child: tile.croppedImageTile(1 / taille_grille),
        onTap: () {
          moveTile(tile.position_actuelle);
        },
      );
    }
  }
}
