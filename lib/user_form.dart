import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/storage_service.dart';
import 'package:my_certificate/utils.dart';

class UserForm extends StatefulWidget {
  UserForm();

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  final _informationFormKey = GlobalKey<FormState>();
  Certificate certificate;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Certificate>(
        future: StorageService.getStoredCertificate(),
        builder: (BuildContext context, AsyncSnapshot<Certificate> snapshot) {
          if (snapshot.hasData) {
            certificate = snapshot.data;

            return Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: buildGeneralForm()),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Text('Enregistrer', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      if (_informationFormKey.currentState.validate()) {
                        _informationFormKey.currentState.save();
                        StorageService.storeCertificate(certificate)
                            .then((value) => {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Information enregistées"),
                                    backgroundColor: Colors.green,
                                  ))
                                });
                      }
                    },
                  ),
                ),
              ),
            ]);
          }
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        });
  }

  Widget buildGeneralForm() {
    return Form(
        key: _informationFormKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: certificate?.lastname,
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
                certificate.lastname = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: certificate?.firstname,
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
                certificate.firstname = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: DateTimeField(
              initialValue: certificate?.birthdate,
              format: Utils.dateFormat,
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
                    initialDate: certificate.birthdate ?? DateTime.now(),
                    lastDate: DateTime.now());
              },
              validator: (DateTime value) =>
                  value == null ? 'Ce champ doit être rempli' : null,
              onSaved: (DateTime value) {
                certificate.birthdate = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: certificate?.birthplace,
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
                certificate.birthplace = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: certificate?.address?.street,
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
                certificate.address.street = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: certificate?.address?.city,
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
                certificate.address.city = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: TextFormField(
              initialValue: certificate?.address?.zipCode,
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
                certificate.address.zipCode = value;
              },
            ),
          ),
        ]));
  }
}