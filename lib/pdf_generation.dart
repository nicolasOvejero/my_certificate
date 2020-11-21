import 'dart:io';

import 'package:my_certificate/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'certificate.dart';

class PdfGeneration {
  static Future<void> createPDF(Certificate values) async {
    final pdf = PdfGeneration.generatePdf(values);

    final output = await getExternalStorageDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(pdf.save());

    OpenFile.open(file.path);
  }

  static pw.Document generatePdf(Certificate values) {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(50),
        build: (pw.Context context) {
          return pw.Column(children: [
            buildHeader(),
            buildPersonalInformation(values),
            buildNote(),
            buildMovementType(values.type),
            buildLegalInformation(values),
          ]);
        }));
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(50),
        build: (pw.Context context) {
          return generateQrcode(values, height: 300, width: 300);
        }));

    return pdf;
  }

  static pw.Widget buildHeader() {
    return pw.Column(children: [
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.only(bottom: 12),
        child: pw.Text("ATTESTATION DE DÉPLACEMENT DÉROGATOIRE",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 19,
            )),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Text(
            "En application du décret n°2020-1310 du 29 octobre 2020 prescrivant"
            " les mesures générales nécessaires pour faire face à l'épidémie de covid-19"
            " 0dans le cadre de l'état d'urgence sanitaire",
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.italic,
              fontSize: 15,
            ),
            textAlign: pw.TextAlign.center),
      ),
    ]);
  }

  static pw.Widget buildPersonalInformation(Certificate values) {
    return pw.Column(children: [
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 6),
        alignment: pw.Alignment.topLeft,
        child: pw.Text("Je soussigné(e),",
            style: pw.TextStyle(
              fontSize: 12,
            ),
        ),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Row(children: [
          pw.Container(
            padding: const pw.EdgeInsets.only(right: 4),
            child: pw.Text(
              "Mme/M. :",
              style: pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          pw.Text(
            '${values.lastname.toUpperCase()} ${values.firstname}',
            style: pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Row(children: [
          pw.Container(
            padding: const pw.EdgeInsets.only(right: 4),
            child: pw.Text(
              "Né(e) le :",
              style: pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.only(right: 4),
            child: pw.Text(
              Utils.dateFormat.format(values.birthdate),
              style: pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.only(right: 4),
            child: pw.Text(
              ", à :",
              style: pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          pw.Text(
            values.birthplace,
            style: pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Row(children: [
          pw.Container(
            padding: const pw.EdgeInsets.only(right: 4),
            child: pw.Text(
              "Demeurant :",
              style: pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          pw.Text(
            '${values.address.street} ${values.address.zipCode} ${values.address.city}',
            style: pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
      ),
    ]);
  }

  static pw.Widget buildNote() {
    return pw.Column(children: [
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Text(
            "certifie que mon déplacement est lié au motif suivant (cocher la case) autorisé par le décret "
            "n°2020-1310 du 29 octobre 2020 prescrivant les mesures générales nécessaires pour faire face "
            "à l'épidémie de covid-19 dans le cadre de l'état d'urgence sanitaire :",
            style: pw.TextStyle(
              fontSize: 12,
            )),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Text(
            "Note : les personnes souhaitant bénéficier de l'une de ces exceptions "
            "doivent se munir s'il y a lieu, lors de leurs déplacements hors de "
            "leur domicile, d'un document leur permettant de justifier que "
            "le déplacement considéré entre dans le champ de l'une de ces exceptions.",
            style: pw.TextStyle(
              fontSize: 9,
            ),
            textAlign: pw.TextAlign.justify),
      ),
    ]);
  }

  static pw.Widget buildMovementType(MovementType value) {
    return pw.Column(children: [
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.work ? pw.Text("X") : null),
          pw.Flexible(
              child: pw.Column(children: [
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Text(
                  "1. Déplacements entre le domicile et le lieu d'exercice "
                  "de l'activité professionnelle ou un établissement d'enseignement ou "
                  "de formation, déplacements professionnels ne pouvant être différés, "
                  "déplacements pour un concours ou un examen.",
                  style: pw.TextStyle(
                    fontSize: 11,
                  )),
            ),
            pw.Text(
                "Note : à utiliser par les travailleurs non-salariés, lorsqu'ils"
                " ne peuvent disposer d'un justificatif de déplacement établi par leur employeur.",
                style: pw.TextStyle(
                  fontSize: 9,
                ),
                textAlign: pw.TextAlign.justify),
          ]))
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.shopping ? pw.Text("X") : null),
          pw.Flexible(
              child: pw.Column(children: [
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Text(
                  "2. Déplacements pour effectuer des achats de "
                  "fournitures nécessaires à l'activité professionnelle, "
                  "des achats de première nécessité dans des établissements "
                  "dont les activités demeurent autorisées, le retrait de "
                  "commande et les livraisons à domicile.",
                  style: pw.TextStyle(
                    fontSize: 11,
                  )),
            ),
            pw.Text(
                "Note : achats de première nécessité y compris les acquisitions à "
                "titre gratuit (distribution de denrées alimentaires...) et les "
                "déplacements liés à la perception de prestations sociales et au retrait d'espèces",
                style: pw.TextStyle(
                  fontSize: 9,
                ),
                textAlign: pw.TextAlign.justify),
          ]))
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.medical ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "3. Consultations, examens et soins ne pouvant être "
                "assurés à distance et l'achat de médicaments.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.family ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "4. Déplacements pour motif familial impérieux, pour "
                "l'assistance aux personnes vulnérables et précaires ou la garde d'enfants.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.handicap ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "5. Déplacement des personnes en situation "
                "de handicap et leur accompagnant.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.sport ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "6. Déplacements brefs, dans la limite d'une heure quotidienne et dans "
                "un rayon maximal d'un kilomètre autour du domicile, liés soit à l'activité "
                "physique individuelle des personnes, à l'exclusion de toute pratique "
                "sportive collective et de toute proximité avec d'autres personnes, soit à la "
                "promenade avec les seules personnes regroupées dans un même domicile, "
                "soit aux besoins des animaux de compagnie.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child:
                  value == MovementType.administrative ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "7. Convocation judiciaire ou administrative et"
                " pour se rendre dans un service public.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child:
                  value == MovementType.general_interest ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "8. Participation à des missions d'intérêt général"
                " sur demande de l'autorité administrative.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child:
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              width: 12,
              height: 12,
              margin: const pw.EdgeInsets.only(right: 8, top: 1),
              decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.BoxBorder(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                  ),
                  shape: pw.BoxShape.rectangle),
              padding: pw.EdgeInsets.only(bottom: 13, left: 2),
              child: value == MovementType.school ? pw.Text("X") : null),
          pw.Flexible(
            child: pw.Text(
                "9. Déplacement pour chercher les enfants à "
                "l'école et à l'occasion de leurs activités périscolaires.",
                style: pw.TextStyle(
                  fontSize: 11,
                )),
          ),
        ]),
      ),
    ]);
  }

  static pw.Widget buildLegalInformation(Certificate values) {
    return pw.Column(children: [
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Row(children: [
          pw.Container(
            padding: const pw.EdgeInsets.only(right: 4),
            child: pw.Text(
              "Fait à :",
              style: pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          pw.Text(
            values.address.city,
            style: pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
      ),
      pw.Row(children: [
        pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.only(right: 4),
                        child: pw.Text(
                          "Le :",
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.only(right: 16),
                        child: pw.Text(
                          Utils.dateFormat.format(values.creationDateTime),
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.only(right: 4),
                        child: pw.Text(
                          ", à :",
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      pw.Text(
                        Utils.hourFormat.format(values.creationDateTime),
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ]),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 32),
                child: pw.Text(
                  "(Date et heure de début de sortie à mentionner obligatoirement)",
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(right: 4),
                      child: pw.Text(
                        "Signature :",
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Text(
                      '${values.lastname.toUpperCase()} ${values.lastname}',
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ]),
            ]),
        pw.Container(
          padding: const pw.EdgeInsets.only(left: 56),
          child: generateQrcode(values),
        ),
      ])
    ]);
  }

  static pw.BarcodeWidget generateQrcode(Certificate values, { double height = 90, double width = 90 }) {
    return pw.BarcodeWidget(
      width: width,
      data: 'Cree le : ${Utils.dateFormat.format(values.creationDateTime)} a ${Utils.hourFormat.format(values.creationDateTime)};\n'
          'Nom: ${values.lastname};\n'
          'Prenom: ${values.firstname};\n'
          'Naissance: ${Utils.dateFormat.format(values.birthdate)} a ${values.birthplace};\n'
          'Sortie: ${Utils.dateFormat.format(values.creationDateTime)} a ${Utils.hourFormat.format(values.creationDateTime)};\n'
          'Motifs: ${Utils.mapMovementTypeToFrench(values.type)};',
      height: height,
      barcode: pw.Barcode.qrCode(),
    );
  }
}
