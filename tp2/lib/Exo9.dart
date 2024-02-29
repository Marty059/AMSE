import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

enum TailleGrille {
  DeuxParDeux,
  TroisParTrois,
  QuatreParQuatre,
  CinqParCinq,
  SixParSix
}

enum NiveauDifficulte {
  Facile,
  Moyen,
  Difficile,
}

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

class Exo9 extends StatefulWidget {
  @override
  _Exo9State createState() => _Exo9State();
}

class _Exo9State extends State<Exo9> {
  int taille_grille = 3;
  List<Tile> tiles = [];
  int deplacement = 0;
  Stopwatch _stopwatch = Stopwatch();
  String _elapsedTime = '';
  bool partieEnCours = false;
  List<int> movesHistory = [];
  NiveauDifficulte _niveauDifficulte = NiveauDifficulte.Moyen;

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

  // Méthode pour générer les tuiles
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

  // Méthode pour déplacer une tuile
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

  // Méthode pour vérifier si un mouvement est valide
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

  // Méthode pour vérifier si le puzzle est résolu
  bool isSolved() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].position_initiale != i) {
        return false;
      }
    }
    return true;
  }

  // Méthode pour mélanger les tuiles
  void shuffleTiles() {
    setState(() {
      // Vider l'historique des mouvements
      movesHistory.clear();

      // Nombre de mouvements aléatoires pour mélanger le taquin
      int numberOfMoves = getNumberOfMovesForDifficulty();

      // Effectuer des mouvements aléatoires valides
      for (int i = 0; i < numberOfMoves; i++) {
        // Obtenir une liste de mouvements valides
        List<int> validMoves = [];
        int emptyTilePosition = tiles.indexWhere((tile) => tile.vide);
        int emptyRow = emptyTilePosition ~/ taille_grille;
        int emptyColumn = emptyTilePosition % taille_grille;

        if (emptyRow > 0) validMoves.add(emptyTilePosition - taille_grille);
        if (emptyRow < taille_grille - 1)
          validMoves.add(emptyTilePosition + taille_grille);
        if (emptyColumn > 0) validMoves.add(emptyTilePosition - 1);
        if (emptyColumn < taille_grille - 1)
          validMoves.add(emptyTilePosition + 1);

        // Choisir un mouvement aléatoire parmi les mouvements valides
        int randomMove = Random().nextInt(validMoves.length);
        int newPosition = validMoves[randomMove];

        // Effectuer le mouvement
        moveTile(newPosition);

        // Vider l'historique des mouvements
        movesHistory.clear();
      }
    });
  }

  // Méthode pour obtenir le nombre de mouvements pour la difficulté actuelle
  int getNumberOfMovesForDifficulty() {
    switch (_niveauDifficulte) {
      case NiveauDifficulte.Facile:
        return 50;
      case NiveauDifficulte.Moyen:
        return 100;
      case NiveauDifficulte.Difficile:
        return 200;
      default:
        return 100;
    }
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
  void changeTailleGrille(TailleGrille tailleGrille) {
    setState(() {
      switch (tailleGrille) {
        case TailleGrille.DeuxParDeux:
          taille_grille = 2;
          break;
        case TailleGrille.TroisParTrois:
          taille_grille = 3;
          break;
        case TailleGrille.QuatreParQuatre:
          taille_grille = 4;
          break;
        case TailleGrille.CinqParCinq:
          taille_grille = 5;
          break;
        case TailleGrille.SixParSix:
          taille_grille = 6;
          break;
      }
      tiles = generateTiles();
    });
  }

  // Ajoutez cette fonction pour obtenir la difficulté actuelle
  TailleGrille _getCurrentTailleGrille() {
    if (taille_grille == 2)
      return TailleGrille.DeuxParDeux;
    else if (taille_grille == 3)
      return TailleGrille.TroisParTrois;
    else if (taille_grille == 4)
      return TailleGrille.QuatreParQuatre;
    else if (taille_grille == 5)
      return TailleGrille.CinqParCinq;
    else
      return TailleGrille.SixParSix;
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Taille du Taquin : '),
                  //SizedBox(height: 5),
                  DropdownButton<TailleGrille>(
                    value: _getCurrentTailleGrille(),
                    onChanged: (TailleGrille? newValue) {
                      if (newValue != null) {
                        changeTailleGrille(newValue);
                      }
                    },
                    items: <TailleGrille>[
                      TailleGrille.DeuxParDeux,
                      TailleGrille.TroisParTrois,
                      TailleGrille.QuatreParQuatre,
                      TailleGrille.CinqParCinq,
                      TailleGrille.SixParSix,
                    ].map<DropdownMenuItem<TailleGrille>>((TailleGrille value) {
                      return DropdownMenuItem<TailleGrille>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Choix de difficulté : '),
                  //SizedBox(height: 5),
                  DropdownButton<NiveauDifficulte>(
                    value: _niveauDifficulte,
                    onChanged: (NiveauDifficulte? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _niveauDifficulte = newValue;
                        });
                      }
                    },
                    items: <NiveauDifficulte>[
                      NiveauDifficulte.Facile,
                      NiveauDifficulte.Moyen,
                      NiveauDifficulte.Difficile,
                    ].map<DropdownMenuItem<NiveauDifficulte>>(
                        (NiveauDifficulte value) {
                      return DropdownMenuItem<NiveauDifficulte>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
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
