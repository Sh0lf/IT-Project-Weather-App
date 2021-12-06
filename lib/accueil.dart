import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstPage_data();
  }
}

class FirstPage_data extends State<FirstPage> {
  String _content = "";
  var temp;
  var humidity;

  Future<void> _loadData() async {
    http.Response response = await http.get(Uri.parse("http://" + _content + "/meteo"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['temperature'];
      this.humidity = results['humidity'];
    });
  }

  Future<String> _getDirPath() async {
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  Future<void> _readData() async {
    final _dirPath = await _getDirPath();
    final _myFile = File('$_dirPath/data.txt');
    final _data = await _myFile.readAsString(encoding: utf8);
    setState(() {
      _content = _data;
    });
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: RefreshIndicator(
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
                        "Currently in NDC :",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.9,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Text(
                      temp != null ? temp.toString() + "\u00B0" : "Please refresh",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600
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
                          trailing: Text(temp != null ? temp.toString() + "\u00B0" : "waiting"),
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.sun),
                          title: Text("Humidity"),
                          trailing: Text(humidity != null ? humidity.toString() + "%" : "waiting"),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
          onRefresh: _loadData,
        ),
      ),
    );
  }
}
