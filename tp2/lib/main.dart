import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Exo1.dart';
import 'package:tp2/Exo2.dart';
import 'package:tp2/Exo4.dart';
import 'package:tp2/Exo5 copy.dart';
import 'package:tp2/Exo5.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Géry et Martin app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 14, 81, 227)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Exo1();
        break;
      case 1:
        page = Exo2();
        break;
      case 2:
        page = Exo4();
        break;
      case 3:
        page = Exo5();
        break;
      case 4:
        page = Exo5_copy();
        break;
      case 5:
        page = Placeholder();
        break;
      case 6:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.one_k),
                  label: 'Exo1',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.two_k),
                  label: 'Exo2',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.four_k),
                  label: 'Exo4',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.five_k),
                  label: 'Exo5',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.five_k_plus),
                  label: 'Exo5_copy',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.six_k),
                  label: 'Exo6',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_convenience_store_sharp),
                  label: 'Taquin',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
