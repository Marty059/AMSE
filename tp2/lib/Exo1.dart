import 'package:flutter/material.dart';

class Exo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Image App'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
              child: Image.network(
            'https://picsum.photos/512/1024',
          ));
        },
      ),
    ));
  }
}
