/*
Exo 6_ter : Gestion de l'échange entre une tuile vide et une tuile adjacente + gestion des mouvements valides
Gestion de la victoire
Ajout d'un bouton pour afficher l'image complète -> aide pour le joueur
*/

import 'package:flutter/material.dart';
import 'dart:math';

class Tile {
  String imageURL;
  Alignment alignment;
  int position_initiale; // Nouveau champ pour conserver la position_initiale de la tuile dans la grille
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
  int taille_grille = 4;
  List<Tile> tiles = [];
  int deplacement = 0;

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

    return tiles;
  }

  Alignment calculateAlignment(int position_initiale) {
    int row = position_initiale ~/ taille_grille; //num ligne
    int column = position_initiale % taille_grille; // num colonne

    double horizontalAlignment = (column / (taille_grille - 1)) * 2 - 1;
    double verticalAlignment = (row / (taille_grille - 1)) * 2 - 1;
    return Alignment(horizontalAlignment, verticalAlignment);
  }

  void moveTile(int position_actuelle) {
    if (!isValidMove(position_actuelle)) {
      return;
    }

    setState(() {
      int emptyTilePosition = 0;
      for (int i = 0; i < tiles.length; i++) {
        if (tiles[i].vide) {
          emptyTilePosition = i;
        }
      }

      Tile emptyTile = tiles[emptyTilePosition];
      Tile tileToSwap = tiles[position_actuelle];

      tiles[position_actuelle] = emptyTile;
      tiles[emptyTilePosition] = tileToSwap;

      emptyTile.position_actuelle = position_actuelle;
      tileToSwap.position_actuelle = emptyTilePosition;
      deplacement += 1;
      print(deplacement);
    });

    // Vérifiez si le puzzle est résolu après le mouvement
    if (isSolved()) {
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
    int emptyTilePosition = 0;
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].vide) {
        emptyTilePosition = i;
      }
    }

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
    // Vérifiez si les indices des tuiles correspondent à leur position_actuelle dans l'image originale
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

  // Méthode pour afficher l'image complète du taquin
  void showFullImage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Aide : Image complète du Taquin'),
        content: Image.network(
            'https://picsum.photos/1024'), // Affichez l'image complète
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

        // Bouton pour afficher l'image complète du taquin
        ElevatedButton(
          onPressed: () {
            showFullImage();
          },
          child: Text('Afficher l\'image complète'),
        ),

        ElevatedButton(
          onPressed: () {
            shuffleTiles();
          },
          child: Text('NE PAS CLIQUER JAMAIS JAMAIS'),
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
      // Sinon, affichez la tuile d'image normale
      return InkWell(
        child: tile.croppedImageTile(1 / taille_grille),
        onTap: () {
          moveTile(tile.position_actuelle);
        },
      );
    }
  }
}
