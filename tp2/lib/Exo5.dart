import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

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

class Exo5 extends StatefulWidget {
  @override
  _Exo5State createState() => _Exo5State();
}

Tile tile = new Tile(
    imageURL: 'https://picsum.photos/1024', alignment: Alignment(0, 0));

class _Exo5State extends State<Exo5> {
  int _currentSliderValueGridCount = 2;

  List<Tile> generateTiles() {
    List<Tile> tiles = [];
    int totalTiles =
        _currentSliderValueGridCount * _currentSliderValueGridCount;

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
        _currentSliderValueGridCount; // Division entière pour obtenir le numéro de ligne
    int column = index %
        _currentSliderValueGridCount; // Modulo pour obtenir le numéro de colonne

    double horizontalAlignment =
        (column / (_currentSliderValueGridCount - 1)) * 2 -
            1; // Calcul de l'alignement horizontal
    double verticalAlignment = (row / (_currentSliderValueGridCount - 1)) * 2 -
        1; // Calcul de l'alignement vertical
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
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            crossAxisCount: _currentSliderValueGridCount,
            children: generateTiles().map((tile) {
              return createTileWidgetFrom(tile);
            }).toList(),
          ),
        ),
        Slider(
          value: _currentSliderValueGridCount.toDouble(),
          min: 2,
          max: 8,
          onChanged: (double value) {
            setState(() {
              _currentSliderValueGridCount = value.toInt();
            });
          },
          divisions: 6,
          label: "$_currentSliderValueGridCount",
        ),
      ],
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(1 / _currentSliderValueGridCount),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
