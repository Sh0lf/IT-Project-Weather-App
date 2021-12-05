import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Container(
                  height: 150.0,
                  width: 300.0,
                  color: Colors.transparent,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: const Center(
                        child: Text("Temperature :",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,),
                      )),
                ),

                Container(
                  height: 150.0,
                  width: 300.0,
                  color: Colors.transparent,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: const Center(
                        child: Text("Humidity :",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,),
                      )),
                ),
              ],)
        )
    );
  }
}