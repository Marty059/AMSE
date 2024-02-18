import 'dart:typed_data';
import 'dart:ui' as ui; // Import nécessaire pour PictureRecorder
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Exo5_copy());
}

class Exo5_copy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taquin Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaquinGame(),
    );
  }
}

class TaquinGame extends StatefulWidget {
  @override
  _TaquinGameState createState() => _TaquinGameState();
}

class _TaquinGameState extends State<TaquinGame> {
  int gridSize = 2;
  late ui.Image image; // Marquer image comme 'late'
  bool isImageLoaded = false; // Indicateur pour vérifier si l'image est chargée

  @override
  void initState() {
    super.initState();
    loadImage('assets/image_carree.png');
  }

  Future<void> loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      image = frameInfo.image;
      isImageLoaded =
          true; // Mettre à jour l'indicateur pour signaler que l'image est chargée
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isImageLoaded) {
      // Si l'image n'est pas encore chargée, affichez un indicateur de chargement ou un écran vide.
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      List<Widget> tiles = [];
      double tileSize = MediaQuery.of(context).size.width / gridSize;

      for (int y = 0; y < gridSize; y++) {
        for (int x = 0; x < gridSize; x++) {
          Rect tileRect = Rect.fromLTWH(
            x * tileSize,
            y * tileSize,
            tileSize,
            tileSize,
          );
          tiles.add(ClipRect(
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Image.memory(
                extractTile(tileRect),
                fit: BoxFit.fill,
              ),
            ),
          ));
        }
      }

      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: gridSize,
                children: tiles,
              ),
            ),
            Slider(
              value: gridSize.toDouble(),
              min: 2,
              max: 5,
              divisions: 3,
              label: gridSize.toString(),
              onChanged: (double value) {
                setState(() {
                  gridSize = value.toInt();
                });
              },
            ),
          ],
        ),
      );
    }
  }

  Uint8List extractTile(Rect rect) {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder, rect);
    Rect imageRect =
        Offset.zero & Size(image.width.toDouble(), image.height.toDouble());
    Rect destRect = Offset.zero & rect.size;
    canvas.drawImageRect(image, imageRect, destRect, Paint());
    ui.Picture picture = recorder.endRecording();
    ui.Image img =
        picture.toImage(rect.width.toInt(), rect.height.toInt()) as ui.Image;
    ByteData byteData =
        img.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    return byteData.buffer.asUint8List();
  }
}
