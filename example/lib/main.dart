import 'package:flutter/material.dart';
import 'package:flutter_utils_z/src/flutter_utils_z.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    initSync();
    super.initState();
  }

  void initSync() async {
    final path = await FlutterUtils.getAssetPathPrefix('assets/images/sound_bg.png');
    print('path = $path');

    final fullPath = await FlutterUtils.getAssetPath('assets/images/sound_bg.png');
    print('fullPath = $fullPath');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Image.asset(
            'assets/images/sound_bg.png',
            width: 200,
            height: 100,
          ),
        ),
      ),
    );
  }
}
