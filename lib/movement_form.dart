import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/storage_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovementForm extends StatefulWidget {
  final Function callbackTabBar;

  MovementForm(this.callbackTabBar);

  @override
  MovementFormState createState() => MovementFormState();
}

class MovementFormState extends State<MovementForm> {
  Certificate certificate = new Certificate();
  final AsyncMemoizer _getOneCertificate = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _getOneCertificate.runOnce(() => StorageService.getStoredCertificate()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            certificate = snapshot.data;
            return SingleChildScrollView(child: _buildMovementForm(context));
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

  Widget _buildMovementForm(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 16),
          child: RadioListTile(
            title: Text(AppLocalizations.of(context).movementFormWorkExp),
            value: MovementType.work,
            groupValue: certificate.type,
            onChanged: (MovementType value) {
              setState(() {
                certificate.type = value;
              });
            },
          )),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormShoppingExp),
        value: MovementType.shopping,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormMedicalExp),
        value: MovementType.medical,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormFamilyExp),
        value: MovementType.family,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormHandicapExp),
        value: MovementType.handicap,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormSportExp),
        value: MovementType.sport,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormAdministrativeExp),
        value: MovementType.administrative,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      RadioListTile(
        title: Text(AppLocalizations.of(context).movementFormGeneralInterestExp),
        value: MovementType.general_interest,
        groupValue: certificate.type,
        onChanged: (MovementType value) {
          setState(() {
            certificate.type = value;
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(thickness: 2)
      ),
      Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: RadioListTile(
            title: Text(AppLocalizations.of(context).movementFormSchoolExp),
            value: MovementType.school,
            groupValue: certificate.type,
            onChanged: (MovementType value) {
              setState(() {
                certificate.type = value;
              });
            },
          )),
      SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child:
              Text(
                  AppLocalizations.of(context).movementFormAction,
                  style: TextStyle(fontSize: 18)
              ),
          onPressed: () async {
            certificate.creationDateTime = DateTime.now();
            await StorageService.storeCertificate(certificate);
            widget.callbackTabBar(2);
            Scaffold.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.only(left: 24, top: 8, bottom: 8),
              content: Text(AppLocalizations.of(context).movementFormSnackBar),
              backgroundColor: Colors.green,
            ));
          },
        ),
      ),
    ]);
  }
}
