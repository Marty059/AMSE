import 'package:flutter/material.dart';
import 'dart:math' as math;

// Modèle de tuile
math.Random random = new math.Random();

class Tile {
  late Color color;
  late String text;

  Tile(this.color, this.text);
  Tile.randomColor(int index)
      : color = index == 0 ? Colors.white : Colors.grey,
        text = index == 0 ? 'empty$index' : 'tile$index';
}

// Widget de tuile
class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return coloredBox(tile.text, tile.color);
  }

  Widget coloredBox(String text, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
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
/* tentative de code qui marche pas sad
  
  List generateListe(int taille){
    List<int> liste = [];
    
    for (int i = 0; i < taille; i++){
      if (i>0){
        int nombre = 0;
        while (liste[i]!=nombre){
          nombre = random.nextInt(taille);
        }
        liste.add(nombre);
      }
      else{
        liste.add(random.nextInt(taille));
      }
    }
    return liste;
  }

  List<Widget> tiles = [];

  void generateTiles(int taille){
    List listeNombre = generateListe(taille);
    for (int i = 0; i < taille; i++){
      tiles.add(Tile.randomColor(listeNombre[i]) as Widget);
    }
     
  } */

  // Liste des tuiles
  List<Widget> tiles = List<Widget>.generate(
      9, (index) => TileWidget(Tile.randomColor(index))); // 9 tuiles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0, // Espacement vertical entre les tuiles
        crossAxisSpacing: 8.0, // Espacement horizontal entre les tuiles
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
