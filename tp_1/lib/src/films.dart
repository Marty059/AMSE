import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/main.dart';
import 'package:tp_1/models.dart';

class FilmsPage extends StatelessWidget {
  const FilmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: films.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Image.asset(films[index]
                .imageUrl), // Utilise Image.asset pour les images dans les assets
            trailing: Text(films[index].title),
          ),
        );
      },
    );
  }
}
