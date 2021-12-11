import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class FirstPage extends StatefulWidget {
  // creation de la classe pour la page principale
  @override
  State<StatefulWidget> createState() {
    return FirstPage_data();
  }
}

class FirstPage_data extends State<FirstPage> {
  // définition des variables necessaires pour recuperer les données
  String _ip = ""; // variable pour récuperer l'ip du serveur
  var temp;
  var humidity;
  var time="";

  Future<void> _loadData() async {
    // fonction pour récuperer les données du serveur
    http.Response response =
        await http.get(Uri.parse("http://" + _ip + "/meteo")).timeout(
      const Duration(seconds: 2),
      onTimeout: () {
        // si on a rien au bout de 2 secondes
        return http.Response('Error', 503); // on retourne un code d'erreur 500
      },
    );

    if (response.statusCode == 200) {
      // si le code est 200
      var results = jsonDecode(response.body);
      setState(() {
        // on modifie les variables avec les valeurs retournées par le serveur
        this.temp = results['temperature'];
        this.humidity = results['humidity'];
        this.time = results['date'];
      });
    } else if (response.statusCode == 601) { // si le code est 601
      Fluttertoast.showToast( // on affiche un message pour dire d'attendre avant de rafraichir
          msg: "Error : try to refresh later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      // sinon
      Fluttertoast.showToast(
          // on affiche un message pour dire que le serveur ne répond pas
          msg: "Error : the server is not responding",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  Future<String> _getDirPath() async {
    // fonction pour récuperer le chemin attribuée par le téléphone pour les fichiers de l'application
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  Future<void> _readData() async {
    // fonction pour récuperer l'ip stockée dans un fichier texte
    final _dirPath = await _getDirPath();
    final _myFile = File('$_dirPath/data.txt');
    final _data = await _myFile.readAsLines(encoding: utf8);
    setState(() {
      _ip = _data[0];
    });
    _loadData();
  }

  @override
  void initState() {
    // à chaque fois qu'on arrive sur la page on récupere l'ip du serveur
    super.initState();
    _readData();
  }

  Widget build(BuildContext context) {
    // création de la page principale
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          // widget pour rafraichir la page
          backgroundColor: Colors.white38,
          color: Colors.redAccent,
          displacement: 50,
          strokeWidth: 3,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Currently from the server :",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.9,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      temp != null
                          ? temp.toString() + "\u00B0"
                          : "Please refresh",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Updated time:" + time != ""
                            ? time.toString()
                            : "Loading",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      // affichage de la temperature mesurée par le capteur
                      leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: const Text("Temperature"),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u00B0"
                          : "waiting"),
                    ),
                    ListTile(
                      // affichage de l'humidité mesurée par le capteur
                      leading: const FaIcon(FontAwesomeIcons.sun),
                      title: const Text("Humidity"),
                      trailing: Text(humidity != null
                          ? humidity.toString() + "%"
                          : "waiting"),
                    ),
                  ],
                ),
              ))
            ],
          ),
          onRefresh:
              _loadData, // si on rafraichit la page, on appelle la fonction _loadData()
        ),
      ),
    );
  }
}
