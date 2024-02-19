import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

class Exo5 extends StatefulWidget {
  @override
  _Exo5State createState() => _Exo5State();
}

Tile tile = new Tile(
    imageURL: 'https://picsum.photos/1024', alignment: Alignment(0, 0));

class _Exo5State extends State<Exo5> {
  int gridRowCount = 4; // Nombre de lignes de la grille
  int gridColumnCount = 4; // Nombre de colonnes de la grille

  List<Tile> generateTiles() {
    List<Tile> tiles = [];
    int totalTiles = gridRowCount * gridColumnCount;

    for (int i = 0; i < totalTiles; i++) {
      tiles.add(Tile(
        imageURL: 'https://picsum.photos/1024',
        alignment: calculateAlignment(i),
      ));
    }

    return tiles;
  }

  Alignment calculateAlignment(int index) {
    int row = index ~/
        gridColumnCount; // Division entière pour obtenir le numéro de ligne
    int column =
        index % gridColumnCount; // Modulo pour obtenir le numéro de colonne

    double horizontalAlignment = (column / (gridColumnCount - 1)) * 2 -
        1; // Calcul de l'alignement horizontal
    double verticalAlignment =
        (row / (gridRowCount - 1)) * 2 - 1; // Calcul de l'alignement vertical
    print("case numero : $index");
    print(horizontalAlignment);
    print(verticalAlignment);
    return Alignment(horizontalAlignment, verticalAlignment);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Cropped Image",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            crossAxisCount: gridColumnCount,
            children: generateTiles().map((tile) {
              return tile.croppedImageTile();
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
