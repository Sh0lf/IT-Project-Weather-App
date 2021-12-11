import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ThirdPage extends StatefulWidget {
  // classe pour la troisième page, les différents réglages
  @override
  State<StatefulWidget> createState() {
    return ThirdPage_data();
  }
}

class ThirdPage_data extends State<ThirdPage> {
  String _content = ""; // variable pour stocker l'ip du serveur

  Future<String> _getDirPath() async {
    // fonction pour récuperer le chemin attribuée par le téléphone pour les fichiers de l'application
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  Future<void> _readData() async {
    // fonction pour lire l'ip du serveur stockée dans le fichier data.txt
    final _dirPath = await _getDirPath();
    final _myFile = File('$_dirPath/data.txt');
    final _data = await _myFile.readAsString(encoding: utf8);
    setState(() {
      _content = _data;
    });
  }

  final _textController =
      TextEditingController(); // textcontroller pour récuperer ce que rentre l'utilisateur dans le champs texte

  Future<void> _writeData() async {
    // fonction pour écrire l'ip rentrée par l'utilisateur dans le champs dans le fichier data.txt
    final _dirPath = await _getDirPath();

    final _myFile = File("$_dirPath/data.txt");

    await _myFile.writeAsString(_textController.text);
    // on remplace tout ce qu'il ya dans le fichier par l'ip rentrée par l'utilisateur
    _textController.clear();
    // on supprime ce que l'utilisateur a rentrée dans le champs une fois qu'il a validé.
  }

  @override
  Widget build(BuildContext context) {
    // création de la page des réglages
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  // affichage d'un texte au centre
                  "Settings",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  // affichage d'un champ texte
                  controller: _textController,
                  decoration: const InputDecoration(
                      labelText: 'Enter the ip of the server'),
                ),
                ElevatedButton(
                  // bouton pour sauvegarder l'ip rentrée par l'utilisateur
                  child: const Text('Save to file'),
                  onPressed:
                      _writeData, // si on appuie sur le bouton, alors on call la fonction pour écrire les données dans le fichier texte
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                    // affichage d'un texte
                    _content != null ? _content : 'Check the ip of the server',
                    style: const TextStyle(fontSize: 24, color: Colors.pink)),
                ElevatedButton(
                  // affichage d'un bouton pour lire l'adresse ip
                  child: const Text('Read the ip of the server'),
                  onPressed:
                      _readData, // si le bouton est préssé, on call la fonction _readData()
                ),
                const Divider(
                  height: 50,
                  thickness: 3,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                const Text(
                  // affichage d'un texte au centre
                  "Credits",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  // affichage d'un texte au centre
                  "Application created by the Rasputin Team as part of our project to deepen computer science with Flutter. \n\nYou can get the weather from a DHT11 sensor installed on a development board that will serve as a server with Flask. You also have access to the weather of Paris.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
