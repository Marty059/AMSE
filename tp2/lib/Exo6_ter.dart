import 'package:flutter/material.dart';
import 'dart:math';

class Tile {
  String imageURL;
  Alignment alignment;
  int index; // Nouveau champ pour conserver l'index de la tuile dans la grille
  int position;
  bool vide;

  Tile(
      {required this.imageURL,
      required this.alignment,
      required this.index,
      required this.position,
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

class Exo6_ter extends StatefulWidget {
  @override
  _Exo6_terState createState() => _Exo6_terState();
}

class _Exo6_terState extends State<Exo6_ter> {
  int _currentSliderValueGridCount =
      2; // Changer la taille de la grille pour un jeu de taquin 3x3

  List<Tile> tiles = []; // Liste des tuiles
  int emptyIndex = 0;
  int emptyIndexposition = 0;

  @override
  void initState() {
    super.initState();
    tiles = generateTiles();
  }

  List<Tile> generateTiles() {
    List<Tile> tiles = [];
    int totalTiles =
        _currentSliderValueGridCount * _currentSliderValueGridCount;

    for (int i = 0; i < totalTiles; i++) {
      tiles.add(Tile(
        imageURL: 'https://picsum.photos/1024',
        alignment: calculateAlignment(i),
        index: i,
        position: i,
        vide: false,
      ));
    }

    // Initialiser l'index de la tuile vide (dans cet exemple, la dernière tuile)
    emptyIndex = totalTiles - 1;
    emptyIndexposition = emptyIndex;

    return tiles;
  }

  Alignment calculateAlignment(int index) {
    int row = index ~/
        _currentSliderValueGridCount; // Division entière pour obtenir le numéro de ligne
    int column = index %
        _currentSliderValueGridCount; // Modulo pour obtenir le numéro de colonne

    double horizontalAlignment =
        (column / (_currentSliderValueGridCount - 1)) * 2 -
            1; // Calcul de l'alignement horizontal
    double verticalAlignment = (row / (_currentSliderValueGridCount - 1)) * 2 -
        1; // Calcul de l'alignement vertical
    return Alignment(horizontalAlignment, verticalAlignment);
  }

  void moveTile(int index) {
    int position = positionOfIndex(index);
    // Vérifiez si la tuile sélectionnée peut être déplacée
    if (!isValidMove(position_initiale)) {
      return;
    }

    // Permutez la tuile sélectionnée avec la tuile vide
    setState(() {
      Tile temp = tiles[index];
      tiles[index] = tiles[emptyIndex];
      tiles[emptyIndex] = temp;

      emptyIndex = position_initiale;
      for (int i = 0; i < tiles.length; i++) {
        if (tiles[i].position_initiale == tiles.length - 1) {
          emptyIndexposition = tiles[i].position_actuelle;
          break;
        }
      }
    });

    // Vérifiez si le puzzle est résolu après le mouvement
    if (isSolved()) {
      // Gérer le cas où le puzzle est résolu
      // Par exemple, afficher un message de réussite
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Félicitations !'),
          content: Text('Vous avez résolu le puzzle !'),
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

  bool isValidMove(int position) {
    int emptyRow = emptyIndexposition ~/ _currentSliderValueGridCount;
    int emptyColumn = emptyIndexposition % _currentSliderValueGridCount;
    int targetRow = position ~/ _currentSliderValueGridCount;
    int targetColumn = position % _currentSliderValueGridCount;

    return (emptyRow == targetRow &&
            (emptyColumn - 1 == targetColumn ||
                emptyColumn + 1 == targetColumn)) ||
        (emptyColumn == targetColumn &&
            (emptyRow - 1 == targetRow || emptyRow + 1 == targetRow));
  }

  bool isSolved() {
    // Vérifiez si les indices des tuiles correspondent à leur position dans l'image originale
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].index != i) {
        return false;
      }
    }
    return true;
  }

  int positionOfIndex(int index) {
    int temp = 0;
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].index == index) {
        temp = tiles[i].position;
      }
    }
    return temp;
  }

  void checkPositionTileVide() {
    setState(() {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i].position_actuelle = i;
      }

      // Trouvez la nouvelle position_actuelle de la tuile vide
      for (int i = 0; i < tiles.length; i++) {
        if (tiles[i].vide) {
          emptyIndexposition = tiles[i].position_actuelle;
          break;
        }
      }
    });
  }

  void checkPosition() {
    setState(() {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i].position_actuelle = i;
      }
    });
  }

  int position_initiale_vide() {
    int temp = 0;
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].vide) {
        temp = tiles[i].position_initiale;
      }
    }
    return temp;
  }

  void shuffleTiles() {
    setState(() {
      // Mélangez les tuiles en permutant aléatoirement les tuiles
      for (int i = tiles.length - 1; i > 0; i--) {
        int j = Random().nextInt(i + 1);
        Tile temp = tiles[i];

        tiles[i] = tiles[j];

        tiles[j] = temp;
        checkVide();
      }

      checkPositionTileVide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Affichage du jeu de taquin
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            crossAxisCount: _currentSliderValueGridCount,
            children: tiles.map((tile) {
              return createTileWidgetFrom(tile);
            }).toList(),
          ),
        ),
        // Bouton pour mélanger les tuiles (optionnel)
        ElevatedButton(
          onPressed: () {
            // Mélangez les tuiles (implémentation requise)
            shuffleTiles();
          },
          child: Text('Mélanger'),
        ),
      ],
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    if (tile.index == emptyIndex) {
      return Opacity(
          opacity: 0.2,
          child: InkWell(
            child: tile.croppedImageTile(1 / _currentSliderValueGridCount),
            onTap: () {
              checkPositionTileVide();
              // Gérez ici les interactions de déplacement de la tuile
              // (implémentation requise)
              moveTile(tile.position_actuelle);
              print("position_actuelle initale: " +
                  tile.position_initiale.toString());
              print("position_actuelle actuelle :" +
                  tile.position_actuelle.toString());
              print("position_actuelle initale vide :" + emptyIndex.toString());
              print("position_actuelle actuelle vide :" +
                  emptyIndexposition.toString());
              print("====");
            },
          ));
    } else {
      // Sinon, affichez la tuile d'image normale
      return InkWell(
        child: tile.croppedImageTile(1 / _currentSliderValueGridCount),
        onTap: () {
          checkPositionTileVide();
          // Gérez ici les interactions de déplacement de la tuile
          // (implémentation requise)
          moveTile(tile.position_actuelle);
          print("position_actuelle initiale: " +
              tile.position_initiale.toString());
          print("position_actuelle :" + tile.position_actuelle.toString());
          print("====");
        },
      );
    }
  }
}
