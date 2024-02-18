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

Tile tile =
    new Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));

class _Exo5State extends State<Exo5> {
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
            crossAxisCount: 3,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("1"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("2"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("3"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("4"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("5"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("6"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("7"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("8"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("9"),
              ),
            ],
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
