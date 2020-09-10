import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cpp_playground/flutter_cpp_playground.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion =
          "${FlutterCppPlayground.generateName(new Random().nextInt(1000))}";
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mythical Name Generator'),
        ),
        body: Center(
          child: Text(
            'Your mythical name is: $_platformVersion\n',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.autorenew,
            size: 30.0,
          ),
          onPressed: () {
            initPlatformState();
          },
        ),
      ),
    );
  }
}
