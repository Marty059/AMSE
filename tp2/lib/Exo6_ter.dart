import 'package:flutter/material.dart';
import 'dart:math';

class Tile {
  String imageURL;
  Alignment alignment;
  int position_initiale; // Nouveau champ pour conserver l'position_initiale de la tuile dans la grille
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

class Exo6_ter extends StatefulWidget {
  @override
  _Exo6_terState createState() => _Exo6_terState();
}

class _Exo6_terState extends State<Exo6_ter> {
  int taille_grille =
      3; // Changer la taille de la grille pour un jeu de taquin 3x3

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

    // Initialiser l'position_initiale de la tuile vide (dans cet exemple, la dernière tuile)
    emptyIndex = totalTiles - 1;
    emptyIndexposition = emptyIndex;

    return tiles;
  }

  Alignment calculateAlignment(int position_initiale) {
    int row = position_initiale ~/
        taille_grille; // Division entière pour obtenir le numéro de ligne
    int column = position_initiale %
        taille_grille; // Modulo pour obtenir le numéro de colonne

    double horizontalAlignment = (column / (taille_grille - 1)) * 2 -
        1; // Calcul de l'alignement horizontal
    double verticalAlignment =
        (row / (taille_grille - 1)) * 2 - 1; // Calcul de l'alignement vertical
    return Alignment(horizontalAlignment, verticalAlignment);
  }

  void moveTile(int position_initiale) {
    // Vérifiez si la tuile sélectionnée peut être déplacée
    if (!isValidMove(position_initiale)) {
      return;
    }

    // Permutez la tuile sélectionnée avec la tuile vide
    setState(() {
      Tile temp = tiles[position_initiale];
      tiles[position_initiale] = tiles[emptyIndex];
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

  bool isValidMove(int position_actuelle) {
    int emptyRow = emptyIndexposition ~/ taille_grille;
    int emptyColumn = emptyIndexposition % taille_grille;
    int targetRow = position_actuelle ~/ taille_grille;
    int targetColumn = position_actuelle % taille_grille;

    return (emptyRow == targetRow &&
            (emptyColumn - 1 == targetColumn ||
                emptyColumn + 1 == targetColumn)) ||
        (emptyColumn == targetColumn &&
            (emptyRow - 1 == targetRow || emptyRow + 1 == targetRow));
  }

  bool isSolved() {
    // Vérifiez si les indices des tuiles correspondent à leur position_actuelle dans l'image originale
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].position_initiale != i) {
        return false;
      }
    }
    return true;
  }

  int positionActuelleOfPositionInitiale(int position_initiale) {
    int temp = 0;
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].position_initiale == position_initiale) {
        temp = tiles[i].position_actuelle;
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

  void shuffleTiles() {
    setState(() {
      // Mélangez les tuiles en permutant aléatoirement les tuiles
      for (int i = tiles.length - 1; i > 0; i--) {
        int j = Random().nextInt(i + 1);
        Tile temp = tiles[i];

        tiles[i] = tiles[j];

        tiles[j] = temp;
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
            crossAxisCount: taille_grille,
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
    if (tile.vide) {
      return Opacity(
          opacity: 0.2,
          child: InkWell(
            child: tile.croppedImageTile(1 / taille_grille),
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
        child: tile.croppedImageTile(1 / taille_grille),
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
