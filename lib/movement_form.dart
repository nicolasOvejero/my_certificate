import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/pdf_generation.dart';

class MovementForm extends StatefulWidget {
  Certificate certificate = new Certificate();

  MovementForm(this.certificate);

  @override
  MovementFormState createState() => MovementFormState();
}

class MovementFormState extends State<MovementForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 16),
          child: ListTile(
            title: const Text(
                "Déplacements entre le domicile et le lieu d'exercice de l'activité "
                    "professionnelle ou un établissement d'enseignement ou de formation, "
                    "déplacements professionnels ne pouvant être différés, "
                    "déplacements pour un concours ou un examen."),
            leading: Radio(
              value: MovementType.work,
              groupValue: widget.certificate.type,
              onChanged: (MovementType value) {
                setState(() {
                  widget.certificate.type = value;
                });
              },
            ),
          )),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Déplacements pour effectuer des achats de fournitures nécessaires à "
                "l'activité professionnelle, des achats de première nécessité dans "
                "des établissements dont les activités demeurent autorisées, "
                "le retrait de commande et les livraisons à domicile."),
        leading: Radio(
          value: MovementType.shopping,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Consultations, examens et soins ne pouvant être assurés à "
                "distance et l'achat de médicaments."),
        leading: Radio(
          value: MovementType.medical,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Déplacements pour motif familial impérieux, pour l'assistance aux "
                "personnes vulnérables et précaires ou la garde d'enfants."),
        leading: Radio(
          value: MovementType.family,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Déplacement des personnes en situation de handicap et leur accompagnant."),
        leading: Radio(
          value: MovementType.handicap,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Déplacements brefs, dans la limite d'une heure quotidienne et dans un "
                "rayon maximal d'un kilomètre autour du domicile, liés soit à l'activité "
                "physique individuelle des personnes, à l'exclusion de toute pratique "
                "sportive collective et de toute proximité avec d'autres personnes, "
                "soit à la promenade avec les seules personnes regroupées dans un "
                "même domicile, soit aux besoins des animaux de compagnie."),
        leading: Radio(
          value: MovementType.sport,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Convocation judiciaire ou administrative et pour se "
                "rendre dans un service public."),
        leading: Radio(
          value: MovementType.administrative,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      ListTile(
        title: const Text(
            "Participation à des missions d'intérêt général sur "
                "demande de l'autorité administrative."),
        leading: Radio(
          value: MovementType.general_interest,
          groupValue: widget.certificate.type,
          onChanged: (MovementType value) {
            setState(() {
              widget.certificate.type = value;
            });
          },
        ),
      ),
      Divider(thickness: 2),
      Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: const Text(
                "Déplacement pour chercher les enfants à l'école et à "
                    "l'occasion de leurs activités périscolaires."),
            leading: Radio(
              value: MovementType.school,
              groupValue: widget.certificate.type,
              onChanged: (MovementType value) {
                setState(() {
                  widget.certificate.type = value;
                });
              },
            ),
          )),
      SizedBox(
        width: double.infinity,
        child: RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child:
              Text('Générer mon attestation', style: TextStyle(fontSize: 18)),
          onPressed: () async {
            await PdfGeneration.createPDF(widget.certificate);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Attestation générée"),
              backgroundColor: Colors.green,
            ));
          },
        ),
      ),
    ]);
  }
}
