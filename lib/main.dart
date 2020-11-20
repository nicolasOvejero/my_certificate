import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/pdf_generation.dart';
import 'package:my_certificate/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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
      home: MyHomePage(title: 'Mon attestation'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    createPDF();
  }

  Future<void> createPDF() async {
    Certificate values = new Certificate();
    values.lastname = "Ovejero";
    values.firstname = "Nicolas";
    values.birthdate = "15/07/1995";
    values.birthplace = "Nantua";
    values.address = new Address();
    values.address.city = "Villeurbanne";
    values.address.zipCode = "69100";
    values.address.street = "106 Boulevard du 11 Novembre 1918";
    values.type = MovementType.work;
    values.creationDate = "20/11/2020";
    values.creationTime = "20:20";

    final pdf = PdfGeneration.generatePdf(values);

    final output = await getExternalStorageDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(pdf.save());

    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
