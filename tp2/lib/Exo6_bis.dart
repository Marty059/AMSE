import 'package:flutter/material.dart';
import 'dart:math' as math;

// Modèle de tuile
math.Random random = new math.Random();

class Tile {
  late Color color;

  Tile(this.color);
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

// Widget de tuile
class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return coloredBox();
  }

  Widget coloredBox() {
    return Container(
      color: tile.color,
      child: Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Exo6_bis()));

// Widget principal pour afficher les tuiles
class Exo6_bis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Exo6_bisState();
}

// État du widget principal
class Exo6_bisState extends State<Exo6_bis> {
  // Liste des tuiles
  List<Widget> tiles = List<Widget>.generate(
      9, (index) => TileWidget(Tile.randomColor())); // 9 tuiles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: tiles,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_very_satisfied),
        onPressed: () {
          swapTiles(2, 3); // Exemple: échanger les tuiles 2 et 3
        },
      ),
    );
  }

  void swapTiles(int index1, int index2) {
    setState(() {
      if (index1 >= 0 &&
          index1 < tiles.length &&
          index2 >= 0 &&
          index2 < tiles.length &&
          index1 != index2) {
        final temp = tiles[index1];
        tiles[index1] = tiles[index2];
        tiles[index2] = temp;

        // Mettre à jour l'état avec la nouvelle liste réorganisée
        tiles = List.from(tiles);
      }
    });
  }
}
