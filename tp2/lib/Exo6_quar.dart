import 'package:flutter/material.dart';
import 'dart:math';

class Tile {
  String imageURL;
  Alignment alignment;
  int index; // Nouveau champ pour conserver l'index de la tuile dans la grille

  Tile({required this.imageURL, required this.alignment, required this.index});

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

class Exo6_quar extends StatefulWidget {
  @override
  _Exo6_quarState createState() => _Exo6_quarState();
}

class _Exo6_quarState extends State<Exo6_quar> {
  int _currentSliderValueGridCount =
      2; // Changer la taille de la grille pour un jeu de taquin 3x3

  List<Tile> tiles = []; // Liste des tuiles
  int emptyIndex = 0; // Index de la tuile vide

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
      ));
    }

    // Initialiser l'index de la tuile vide (dans cet exemple, la dernière tuile)
    emptyIndex = totalTiles - 1;

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
    // Vérifiez si la tuile sélectionnée peut être déplacée
    if (!isValidMove(index)) {
      return;
    }

    // Permutez la tuile sélectionnée avec la tuile vide
    setState(() {
      Tile temp = tiles[index];
      tiles[index] = tiles[emptyIndex];
      tiles[emptyIndex] = temp;

      emptyIndex = index;
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

  bool isValidMove(int index) {
    // Vérifiez si la tuile sélectionnée est adjacente à la tuile vide
    if ((index == emptyIndex - 1 &&
            index % _currentSliderValueGridCount != 0) || // À gauche
        (index == emptyIndex + 1 &&
            emptyIndex % _currentSliderValueGridCount != 0) || // À droite
        index == emptyIndex - _currentSliderValueGridCount || // En haut
        index == emptyIndex + _currentSliderValueGridCount) {
      // En bas
      return true;
    }
    return false;
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

  void shuffleTiles() {
    // Générez une liste d'indices valides pour les tuiles adjacentes à la tuile vide
    List<int> adjacentIndices = [];

    // Vérifiez si la tuile à gauche de la tuile vide est valide
    if (emptyIndex % _currentSliderValueGridCount != 0) {
      adjacentIndices.add(emptyIndex - 1);
    }

    // Vérifiez si la tuile à droite de la tuile vide est valide
    if (emptyIndex % _currentSliderValueGridCount !=
        _currentSliderValueGridCount - 1) {
      adjacentIndices.add(emptyIndex + 1);
    }

    // Vérifiez si la tuile au-dessus de la tuile vide est valide
    if (emptyIndex >= _currentSliderValueGridCount) {
      adjacentIndices.add(emptyIndex - _currentSliderValueGridCount);
    }

    // Vérifiez si la tuile en dessous de la tuile vide est valide
    if (emptyIndex < tiles.length - _currentSliderValueGridCount) {
      adjacentIndices.add(emptyIndex + _currentSliderValueGridCount);
    }

    // Choisissez aléatoirement une direction parmi les directions valides
    int randomIndex = adjacentIndices[Random().nextInt(adjacentIndices.length)];

    // Effectuez le mouvement de la tuile sélectionnée
    setState(() {
      Tile temp = tiles[randomIndex];
      tiles[randomIndex] = tiles[emptyIndex];
      tiles[emptyIndex] = temp;

      emptyIndex = randomIndex;
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
      // Si c'est la tuile vide, affichez un conteneur avec une couleur de fond semi-transparente
      return Container(
        color: Colors.grey.withOpacity(0.5), // Opacité de 50%
      );
    } else {
      // Sinon, affichez la tuile d'image normale
      return InkWell(
        child: tile.croppedImageTile(1 / _currentSliderValueGridCount),
        onTap: () {
          // Gérez ici les interactions de déplacement de la tuile
          // (implémentation requise)
          moveTile(tile.index);
        },
      );
    }
  }
}

//int moves = Random().nextInt(16) + 5;
