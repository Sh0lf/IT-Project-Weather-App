import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ThirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ThirdPage_data();
  }
}

class ThirdPage_data extends State<ThirdPage>{
  String _content = "";

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

  final _textController = TextEditingController();

  Future<void> _writeData() async {
    final _dirPath = await _getDirPath();

    final _myFile = File("$_dirPath/data.txt");

    await _myFile.writeAsString(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter the ip of the server'),
            ),
            ElevatedButton(
              child: const Text('Save to file'),
              onPressed: _writeData,
            ),
            const SizedBox(
              height: 150,
            ),
            Text(
                _content != null ? _content : 'Press the button to se the ip',
                style: const TextStyle(fontSize: 24, color: Colors.pink)),
            ElevatedButton(
              child: const Text('Read the ip of the server'),
              onPressed: _readData,
            )
          ],
        ),
      ),
    );
  }
}
