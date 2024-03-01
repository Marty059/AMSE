import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Exo1.dart';
import 'package:tp2/Exo2.dart';
import 'package:tp2/Exo4.dart';
import 'package:tp2/Exo5.dart';
import 'package:tp2/Exo6.dart';
import 'package:tp2/Exo6_ter.dart';
import 'package:tp2/Exo7_bis.dart';
import 'package:tp2/Exo7_ter.dart';
import 'package:tp2/Exo8_bis.dart';
import 'package:tp2/Home.dart';
import 'package:tp2/Taquin.dart';

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
        debugShowCheckedModeBanner: false,
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
        page = HomePage();
        break;
      case 1:
        page = Exo1();
        break;
      case 2:
        page = Exo2();
        break;
      case 3:
        page = Exo4();
        break;
      case 4:
        page = Exo5();
        break;
      case 5:
        page = Exo6();
        break;
      case 6:
        page = Exo6_ter();
        break;
      case 7:
        page = Exo7_bis();
        break;
      case 8:
        page = Exo8_bis();
        break;
      case 9:
        page = Taquin();
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
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
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
                  icon: Icon(Icons.six_k),
                  label: 'Exo6',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.six_k_plus),
                  label: 'Exo6_ter',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.seven_k),
                  label: 'Exo7_bis',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.eight_k),
                  label: 'Exo8_bis',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_esports),
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
