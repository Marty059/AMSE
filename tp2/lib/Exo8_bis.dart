/*
Exo 8_bis : Interface graphique  de l'AppBar : plus ergonomique
Ajout de l'historique des coups
*/

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

enum Difficulty { easy, medium, hard }

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

class Exo8_bis extends StatefulWidget {
  @override
  _Exo8_bisState createState() => _Exo8_bisState();
}

class _Exo8_bisState extends State<Exo8_bis> {
  int taille_grille = 3;
  List<Tile> tiles = [];
  int deplacement = 0;
  Stopwatch _stopwatch = Stopwatch();
  String _elapsedTime = '';
  bool partieEnCours = false;
  // Déclarez une pile pour stocker l'historique des mouvements
  List<int> movesHistory = [];

  @override
  void initState() {
    super.initState();
    tiles = generateTiles();
  }

  // Méthode pour démarrer le chronomètre
  void _startTimer() {
    _stopwatch.start();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedTime = _stopwatch.elapsed.inSeconds.toString();
        });
      } else {
        timer.cancel();
      }
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

      // Sauvegarder l'état avant le mouvement uniquement s'il y a eu un changement
      if (emptyTile.position_actuelle != position_actuelle) {
        movesHistory.add(emptyTilePosition);
      }

      tiles[position_actuelle] = emptyTile;
      tiles[emptyTilePosition] = tileToSwap;

      emptyTile.position_actuelle = position_actuelle;
      tileToSwap.position_actuelle = emptyTilePosition;

      if (partieEnCours == true) {
        deplacement += 1;

        // Démarrer le chronomètre si ce n'est pas déjà fait
        if (!_stopwatch.isRunning) {
          _startTimer();
        }
      }
    });

    if (partieEnCours == true) {
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
      // Vider l'historique des mouvements
      movesHistory.clear();

      // Nombre de mouvements aléatoires pour mélanger le taquin
      int numberOfMoves = 100;

      // Variable pour stocker la position précédente de la tuile vide
      int? previousEmptyTilePosition;

      // Effectuer des mouvements aléatoires valides
      for (int i = 0; i < numberOfMoves; i++) {
        // Obtenir une liste de mouvements valides
        List<int> validMoves = [];
        int emptyTilePosition = tiles.indexWhere((tile) => tile.vide);
        int emptyRow = emptyTilePosition ~/ taille_grille;
        int emptyColumn = emptyTilePosition % taille_grille;

        // Ajouter les mouvements valides à la liste
        if (emptyRow > 0 &&
            emptyTilePosition - taille_grille != previousEmptyTilePosition) {
          validMoves.add(emptyTilePosition - taille_grille);
        }
        if (emptyRow < taille_grille - 1 &&
            emptyTilePosition + taille_grille != previousEmptyTilePosition) {
          validMoves.add(emptyTilePosition + taille_grille);
        }
        if (emptyColumn > 0 &&
            emptyTilePosition - 1 != previousEmptyTilePosition) {
          validMoves.add(emptyTilePosition - 1);
        }
        if (emptyColumn < taille_grille - 1 &&
            emptyTilePosition + 1 != previousEmptyTilePosition) {
          validMoves.add(emptyTilePosition + 1);
        }

        // Choisir un mouvement aléatoire parmi les mouvements valides
        int randomMove = Random().nextInt(validMoves.length);
        int newPosition = validMoves[randomMove];
        moveTile(newPosition);

        // Mettre à jour la position précédente de la tuile vide
        previousEmptyTilePosition = emptyTilePosition;
      }

      if (!_stopwatch.isRunning) {
        _startTimer();
      }
      movesHistory.clear();
      partieEnCours = true;
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

  // Méthode pour changer la difficulté
  void changeDifficulty(Difficulty difficulty) {
    setState(() {
      switch (difficulty) {
        case Difficulty.easy:
          taille_grille = 2;
          break;
        case Difficulty.medium:
          taille_grille = 2;
          break;
        case Difficulty.hard:
          taille_grille = 4;
          break;
      }
      tiles = generateTiles();
    });
  }

  // Ajoutez cette fonction pour obtenir la difficulté actuelle
  Difficulty _getCurrentDifficulty() {
    if (taille_grille == 3) {
      return Difficulty.easy;
    } else if (taille_grille == 4) {
      return Difficulty.medium;
    } else {
      return Difficulty.hard;
    }
  }

  void undoMove() {
    if (partieEnCours == true) {
      if (movesHistory.isNotEmpty) {
        int lastMove = movesHistory.removeLast();

        setState(() {
          int emptyTilePosition = tiles.indexWhere((tile) => tile.vide);
          Tile emptyTile = tiles[emptyTilePosition];
          Tile tileToSwap = tiles[lastMove];

          tiles[lastMove] = emptyTile;
          tiles[emptyTilePosition] = tileToSwap;

          emptyTile.position_actuelle = lastMove;
          tileToSwap.position_actuelle = emptyTilePosition;

          // Décrémenter le compteur de mouvements
          deplacement -= 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.timer),
                SizedBox(width: 4),
                Text('$_elapsedTime s'),
              ],
            ),
            // Ajoutez le bouton d'annulation ici
            IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {
                if (partieEnCours == true) {
                  undoMove();
                }
              },
            ),
            Row(
              children: [
                Icon(Icons.move_down),
                SizedBox(width: 4),
                Text('$deplacement'),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add a DropdownButton or buttons for selecting difficulty
          DropdownButton<Difficulty>(
            value: _getCurrentDifficulty(),
            onChanged: (Difficulty? newValue) {
              if (newValue != null) {
                changeDifficulty(newValue);
              }
            },
            items: <Difficulty>[
              Difficulty.easy,
              Difficulty.medium,
              Difficulty.hard,
            ].map<DropdownMenuItem<Difficulty>>((Difficulty value) {
              return DropdownMenuItem<Difficulty>(
                value: value,
                child: Text(value.toString().split('.').last),
              );
            }).toList(),
          ),
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
      ),
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
          if (partieEnCours == false) {
            partieEnCours = true;
          }
          moveTile(tile.position_actuelle);
        },
      );
    }
  }
}
