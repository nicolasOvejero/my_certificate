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
          brightness: Brightness.light,
          primaryColor: Utils.hexToColor('#000191'),
          accentColor: Utils.hexToColor('#e1000f'),
          cardColor: Utils.hexToColor('#ebebeb'),
          dialogTheme: DialogTheme(backgroundColor: Colors.white),
          buttonTheme: ButtonThemeData(
              buttonColor: Utils.hexToColor('#000191'),
              textTheme: ButtonTextTheme.primary
          ),
          toggleableActiveColor:  Utils.hexToColor('#000191'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Utils.hexToColor('#000048'),
          accentColor: Utils.hexToColor('#bf000c'),
          cardColor: Utils.hexToColor('#5e5e5e'),
          dialogTheme:
              DialogTheme(backgroundColor: Utils.hexToColor('#d8d8d8')),
          buttonTheme: ButtonThemeData(
              buttonColor: Utils.hexToColor('#000048'),
              textTheme: ButtonTextTheme.primary
          ),
          toggleableActiveColor:  Utils.hexToColor('#000191'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TabBarController(title: 'Mon attestation'));
  }
}
