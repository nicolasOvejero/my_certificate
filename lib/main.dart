import 'package:flutter/material.dart';
import 'package:my_certificate/tab_bar_controller.dart';
import 'package:my_certificate/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon attestation de sortie',
      theme: ThemeData(
        primarySwatch: Utils.createMaterialColor(Utils.hexToColor('#000191')),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabBarController(title: 'Mon attestation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new TabBarController(),
    );
  }
}
