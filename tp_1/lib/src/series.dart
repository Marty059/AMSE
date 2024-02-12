import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/main.dart';
import 'package:tp_1/models.dart';

class SeriePage extends StatelessWidget {
  const SeriePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView.builder(
      itemCount: series.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      series[index].imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          series[index].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Réalisateur: ${series[index].realisateur}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: appState.titleFavoritesSeries
                          .contains(series[index].title)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    appState.toggleFavoriteTitleSeries(series[index].title);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
