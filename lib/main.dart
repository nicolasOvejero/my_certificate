import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/pdf_generation.dart';
import 'package:my_certificate/tab_bar_controller.dart';
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
  Future<void> createPDF() async {
    Certificate values = new Certificate();
    values.lastname = "Ovejero";
    values.firstname = "Nicolas";
    values.birthdate = DateTime(1995, 07, 15);
    values.birthplace = "Nantua";
    values.address = new Address();
    values.address.city = "Villeurbanne";
    values.address.zipCode = "69100";
    values.address.street = "106 Boulevard du 11 Novembre 1918";
    values.type = MovementType.work;
    values.creationDateTime = DateTime.now();

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
      body: new TabBarController(),
    );
  }
}
