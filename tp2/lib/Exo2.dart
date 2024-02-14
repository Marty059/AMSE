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
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://picsum.photos/512/1024',
            ),
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
