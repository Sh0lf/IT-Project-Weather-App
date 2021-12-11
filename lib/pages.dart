import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SecondPage extends StatefulWidget {
  // creation d'une classe pour afficher la meteo de paris
  @override
  State<StatefulWidget> createState() {
    return SecondPage_data();
  }
}

class SecondPage_data extends State<SecondPage> {
  // définition des variables qui vont contenir les données meteo recueillis depuis l'api WeatherAPI
  var temp;
  var description;
  var humidity;
  var windSpeed;
  var updateTime = "";
  var region = "";

  Future<void> _loadData() async {
    // fonction pour récuperer les différentes infos
    http.Response response = await http
        .get(Uri.parse(
            "http://api.weatherapi.com/v1/current.json?key=fea69b4e481a47d5972153151212709&q=Paris"))
        .timeout(
      const Duration(seconds: 2),
      onTimeout: () {
        // au bout de 2secondes d'attente, on dit stop
        return http.Response('Error', 503); // on renvoie un code d'erreur 500
      },
    );

    if (response.statusCode == 200) {
      // si le code de retour est 200
      var results = jsonDecode(response.body);
      setState(() {
        // on modifie les variables avec les valeurs de l'API
        this.temp = results['current']['temp_c'];
        this.description = results['current']['condition']['text'];
        this.humidity = results['current']['humidity'];
        this.windSpeed = results['current']['wind_kph'];
        this.updateTime = results['current']['last_updated'];
        this.region = results['location']["region"];
      });
    }  else {
      // sinon on affiche un message
      Fluttertoast.showToast(
          msg: "Error : the server is not responding",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // à chaque fois qu'on arrive sur la page on charge les données de l'API
    super.initState();
    _loadData();
  }

  Widget build(BuildContext context) {
    // creation de la page qui va afficher les résultats
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          // widget pour refresh la page
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
                        "Currently in Paris :",
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
                        "Updated time:" + updateTime != ""
                            ? updateTime.toString()
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
                      // affiche la temperature
                      leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: const Text("Temperature"),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u00B0"
                          : "waiting"),
                    ),
                    ListTile(
                      // affiche la meteo actuelle
                      leading: const FaIcon(FontAwesomeIcons.cloud),
                      title: const Text("Weather"),
                      trailing: Text(description != null
                          ? description.toString()
                          : "waiting"),
                    ),
                    ListTile(
                      // affiche l'humidité actuelle
                      leading: const FaIcon(FontAwesomeIcons.sun),
                      title: const Text("Humidity"),
                      trailing: Text(humidity != null
                          ? humidity.toString() + "%"
                          : "waiting"),
                    ),
                    ListTile(
                      // affiche la vitesse du vent actuelle
                      leading: const FaIcon(FontAwesomeIcons.wind),
                      title: const Text("Wind Speed"),
                      trailing: Text(windSpeed != null
                          ? windSpeed.toString() + "kph"
                          : "waiting"),
                    ),
                    ListTile(
                      // affiche le lieu actuel
                      leading: const FaIcon(FontAwesomeIcons.locationArrow),
                      title: const Text("Region"),
                      trailing:
                          Text(region != "" ? region.toString() : "waiting"),
                    ),
                  ],
                ),
              ))
            ],
          ),
          onRefresh:
              _loadData, // si on souhaite refresh la page, on relance la fonction pour récuperer les données
        ),
      ),
    );
  }
}
