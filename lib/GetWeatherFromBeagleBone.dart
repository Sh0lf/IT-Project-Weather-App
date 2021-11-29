import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
    MaterialApp(
        title: "Weather App",
        home: Home()
    )
);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var humidity;
  var windSpeed;
  var updateTime;

  Future getWeather (city) async {
    http.Response response = await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=fea69b4e481a47d5972153151212709&q="+city));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['current']['temp_c'];
      this.description = results['current']['condition']['text'];
      this.humidity = results['current']['humidity'];
      this.windSpeed = results['current']['wind_kph'];
      this.updateTime = results['current']['last_updated'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather("Paris");
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Paris",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.9,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Updated time:" + updateTime != null ? updateTime.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget> [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature"),
                      trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description != null ? description.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Humidity"),
                      trailing: Text(humidity != null ? humidity.toString() + "%" : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(windSpeed != null ? windSpeed.toString() + "kph" : "Loading"),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
