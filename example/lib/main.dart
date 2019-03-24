import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_oboe/flutter_oboe.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer _everySecond;
  String _now;
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) async {
      String platformVersion;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        platformVersion = await flutter_oboe.platformVersion;
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
      }

      setState(() {
        _now = DateTime.now().second.toString();
        _platformVersion = platformVersion;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await flutter_oboe.platformVersion;
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
          title: const Text('Oboe Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text('Audio latency : $_platformVersion\n'),
            GestureDetector(
                onTapDown: (TapDownDetails) => flutter_oboe.playTone(),
                onTapUp: (TapDownDetails) => flutter_oboe.stopTone(),
                child: RaisedButton(
                  child: Text("Tap to make a sound"),
                ))
          ],
        )),
      ),
    );
  }
}
