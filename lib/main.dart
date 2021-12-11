import 'package:flutter/material.dart';
import 'pages.dart';
import 'accueil.dart';
import 'settings.dart';

const d_red = Color(0xffe34f2d); // Définition de la couleur pour plus tard

void main() {
  // fonction pour lancer l'application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(), // on apelle la classe home
    );
  }
}

class home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  int _currentIndex = 0; // index de la page sur laquelle on se trouve
  final _pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage()
  ]; // liste qui contient les différentes pages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        // affiche "Weather App" en haut de l'application
        backgroundColor: d_red,
      ),
      body: Center(
        child: _pages[
            _currentIndex], // affiche la page de l'index sur lequel on est
      ),
      bottomNavigationBar: BottomNavigationBar(
        // création d'une barre de navigation
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            // premier item => Bouton home
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: d_red,
          ),
          BottomNavigationBarItem(
            // deuxieme item => Bouton Meteo
            icon: Icon(Icons.cloud),
            label: 'Weather',
            backgroundColor: d_red,
          ),
          BottomNavigationBarItem(
            // troisieme item => Bouton reglages
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: d_red,
          ),
        ],
        onTap: (index) {
          // si on appuie sur un bouton
          setState(() {
            _currentIndex = index; // on change l'index et la page
          });
        },
      ),
    );
  }
}
