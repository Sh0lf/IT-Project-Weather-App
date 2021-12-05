import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'pages.dart';
import 'accueil.dart';
import 'settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const d_red = Color(0xffe34f2d);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}

class home extends StatefulWidget {

  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {

  int _currentIndex = 0;
  final _pages = [FirstPage(), SecondPage(), ThirdPage()];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text('Weather App'),
        backgroundColor: d_red,
      ),
      body: Center(
          child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: d_red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
            backgroundColor: d_red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: d_red,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

