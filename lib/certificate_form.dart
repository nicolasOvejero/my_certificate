import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/pdf_generation.dart';
import 'package:my_certificate/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class CertificateForm extends StatefulWidget {
  Certificate certificate = new Certificate();

  CertificateForm(this.certificate);

  @override
  CertificateFormState createState() => CertificateFormState();
}

class CertificateFormState extends State<CertificateForm> {
  final _informationformKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");
  final hourFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "Informations générales",
            style: TextStyle(
                color: Utils.hexToColor("#e1000f"),
                fontWeight: FontWeight.w700,
                fontSize: 24),
          )),
      Divider(thickness: 2),
      Container(padding: EdgeInsets.only(bottom: 8), child: buildGeneralForm()),
      Container(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            textColor: Colors.white,
            color: Theme
                .of(context)
                .accentColor,
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Text('Enregistrer', style: TextStyle(fontSize: 18)),
            onPressed: () {
              if (_informationformKey.currentState.validate()) {
                _informationformKey.currentState.save();
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Information enregister"),
                      backgroundColor: Colors.green,
                    )
                );
                // createPDF(widget.certificate);
              }
            },
          ),
        ),
      ),
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "Motif du déplacement",
            style: TextStyle(
                color: Utils.hexToColor("#e1000f"),
                fontWeight: FontWeight.w700,
                fontSize: 24),
          )),
      Divider(thickness: 2),
    ]);
  }

  Widget buildGeneralForm() {
    return Form(
        key: _informationformKey,
        autovalidate: true,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.certificate.lastname,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Nom',
              ),
              validator: (value) =>
              value.isEmpty ? 'Ce champ doit être rempli' : null,
              onSaved: (String value) {
                widget.certificate.lastname = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.certificate.firstname,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Prénom',
              ),
              validator: (value) =>
              value.isEmpty ? 'Ce champ doit être rempli' : null,
              onSaved: (String value) {
                widget.certificate.firstname = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: DateTimeField(
              initialValue: widget.certificate.birthdate,
              format: format,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Date de naissance',
              ),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: widget.certificate.birthdate ?? DateTime.now(),
                    lastDate: DateTime.now());
              },
              validator: (DateTime value) =>
              value == null ? 'Ce champ doit être rempli' : null,
              onSaved: (DateTime value) {
                widget.certificate.birthdate = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.certificate.birthplace,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.place),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Lieux de naissance',
              ),
              validator: (value) =>
              value.isEmpty ? 'Ce champ doit être rempli' : null,
              onSaved: (String value) {
                widget.certificate.birthplace = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.certificate.address.street,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.house),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Adresse',
              ),
              validator: (value) =>
              value.isEmpty ? 'Ce champ doit être rempli' : null,
              onSaved: (String value) {
                widget.certificate.address.street = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.certificate.address.city,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.house),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Ville',
              ),
              validator: (value) =>
              value.isEmpty ? 'Ce champ doit être rempli' : null,
              onSaved: (String value) {
                widget.certificate.address.city = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.certificate.address.zipCode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.house),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Code postal',
              ),
              validator: (value) =>
              value.isEmpty ? 'Ce champ doit être rempli' : null,
              onSaved: (String value) {
                widget.certificate.address.zipCode = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: DateTimeField(
              initialValue: widget.certificate.creationDateTime,
              format: format,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Date de sortie',
              ),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: widget.certificate.creationDateTime ??
                        DateTime.now(),
                    lastDate: DateTime.now());
              },
              validator: (DateTime value) =>
              value == null ? 'Ce champ doit être rempli' : null,
              onSaved: (DateTime value) {
                widget.certificate.creationDateTime = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: DateTimeField(
              initialValue: widget.certificate.creationDateTime,
              format: hourFormat,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                labelText: 'Heure de sortie',
              ),
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                      currentValue ?? widget.certificate.creationDateTime),
                );
                return DateTimeField.convert(time);
              },
              validator: (DateTime value) =>
              value == null ? 'Ce champ doit être rempli' : null,
              onSaved: (DateTime value) {
                widget.certificate.creationDateTime = value;
              },
            ),
          ),
        ]));
  }

  Future<void> createPDF(Certificate values) async {
    final pdf = PdfGeneration.generatePdf(values);

    final output = await getExternalStorageDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(pdf.save());

    OpenFile.open(file.path);
  }
}
