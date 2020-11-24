import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/storage_service.dart';

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
            return SingleChildScrollView(child: _buildMovementForm());
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

  Widget _buildMovementForm() {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 16),
          child: RadioListTile(
            title: const Text(
                "Déplacements entre le domicile et le lieu d'exercice de l'activité "
                "professionnelle ou un établissement d'enseignement ou de formation, "
                "déplacements professionnels ne pouvant être différés, "
                "déplacements pour un concours ou un examen."),
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
        title: const Text(
            "Déplacements pour effectuer des achats de fournitures nécessaires à "
            "l'activité professionnelle, des achats de première nécessité dans "
            "des établissements dont les activités demeurent autorisées, "
            "le retrait de commande et les livraisons à domicile."),
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
        title: const Text(
            "Consultations, examens et soins ne pouvant être assurés à "
            "distance et l'achat de médicaments."),
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
        title: const Text(
            "Déplacements pour motif familial impérieux, pour l'assistance aux "
            "personnes vulnérables et précaires ou la garde d'enfants."),
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
        title: const Text(
            "Déplacement des personnes en situation de handicap et leur accompagnant."),
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
        title: const Text(
            "Déplacements brefs, dans la limite d'une heure quotidienne et dans un "
            "rayon maximal d'un kilomètre autour du domicile, liés soit à l'activité "
            "physique individuelle des personnes, à l'exclusion de toute pratique "
            "sportive collective et de toute proximité avec d'autres personnes, "
            "soit à la promenade avec les seules personnes regroupées dans un "
            "même domicile, soit aux besoins des animaux de compagnie."),
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
        title: const Text("Convocation judiciaire ou administrative et pour se "
            "rendre dans un service public."),
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
        title: const Text("Participation à des missions d'intérêt général sur "
            "demande de l'autorité administrative."),
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
            title: const Text(
                "Déplacement pour chercher les enfants à l'école et à "
                "l'occasion de leurs activités périscolaires."),
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
              Text('Générer mon attestation', style: TextStyle(fontSize: 18)),
          onPressed: () async {
            certificate.creationDateTime = DateTime.now();
            await StorageService.storeCertificate(certificate);
            widget.callbackTabBar(2);
            Scaffold.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.only(left: 24, top: 8, bottom: 8),
              content: Text("Attestation générée"),
              backgroundColor: Colors.green,
            ));
          },
        ),
      ),
    ]);
  }
}
