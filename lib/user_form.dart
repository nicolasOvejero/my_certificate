import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/utils.dart';

class UserForm extends StatefulWidget {
  Certificate certificate = new Certificate();

  UserForm(this.certificate);

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  final _informationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16),
          child: buildGeneralForm()),
      SizedBox(
        width: double.infinity,
        child: RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Text('Enregistrer', style: TextStyle(fontSize: 18)),
          onPressed: () {
            if (_informationFormKey.currentState.validate()) {
              _informationFormKey.currentState.save();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Information enregistées"),
                backgroundColor: Colors.green,
              ));
            }
          },
        ),
      ),
    ]);
  }

  Widget buildGeneralForm() {
    return Form(
        key: _informationFormKey,
        autovalidateMode: AutovalidateMode.always,
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
              format: Utils.dateFormat,
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
                    initialDate:
                        widget.certificate.creationDateTime ?? DateTime.now(),
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
              format: Utils.hourFormat,
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
}
