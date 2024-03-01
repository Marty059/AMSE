/*
Exo 2 : Transformer une image
*/

import 'package:flutter/material.dart';

void main() {
  runApp(SliderApp());
}

class SliderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Slider App'),
        ),
        body: Exo2(),
      ),
    );
  }
}

class Exo2 extends StatefulWidget {
  @override
  _Exo2State createState() => _Exo2State();
}

class _Exo2State extends State<Exo2> {
  double _currentSliderValueX = 0;
  double _currentSliderValueZ = 0;
  bool _currentFlipValueX = false;
  double _currentSliderValueScale = 10;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(color: Colors.white),
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateX(_currentSliderValueX * (3.141592653589793 / 180))
                  ..rotateZ(_currentSliderValueZ * (3.141592653589793 / 180))
                  ..scale(_currentSliderValueScale / 10)
                  ..scale(_currentFlipValueX ? -1.0 : 1.0),
                alignment: Alignment.center,
                child: Container(
                  child: Image.network(
                    'https://picsum.photos/512/1024',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text("Rotate X"),
                Expanded(
                  child: Slider(
                    value: _currentSliderValueX,
                    max: 360,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValueX = value;
                      });
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text("Rotate Z"),
                Expanded(
                  child: Slider(
                    value: _currentSliderValueZ,
                    min: 0,
                    max: 360,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValueZ = value;
                      });
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text("Mirror"),
                Checkbox(
                    value: _currentFlipValueX,
                    onChanged: (bool? value) {
                      setState(() {
                        _currentFlipValueX = !_currentFlipValueX;
                      });
                    }),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text("Scale"),
                Expanded(
                  child: Slider(
                    value: _currentSliderValueScale,
                    min: 0,
                    max: 100,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValueScale = value;
                      });
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
