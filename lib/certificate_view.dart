import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/pdf_generation.dart';
import 'package:my_certificate/qrcode_dialog_view.dart';
import 'package:my_certificate/storage_service.dart';
import 'package:my_certificate/utils.dart';

class CertificateView extends StatefulWidget {
  CertificateView();

  @override
  CertificateViewState createState() => CertificateViewState();
}

class CertificateViewState extends State<CertificateView> {
  Certificate certificate;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Certificate>(
        future: StorageService.getStoredCertificate(),
        builder: (BuildContext context, AsyncSnapshot<Certificate> snapshot) {
          if (snapshot.hasData) {
            certificate = snapshot.data;
            return _buildView();
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

  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Mon attestation de sortie",
          style: TextStyle(
              color: Utils.hexToColor('#e1000f'),
              fontSize: 24,
              fontWeight: FontWeight.w900),
        ),
        _buildUserInformation(),
        _buildMovementInformation(),
        _buildDateInformation(),
      ]),
    );
  }

  Widget _buildUserInformation() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(top: 16),
        color: Utils.hexToColor('#ebebeb'),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Attestation pour :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.person_outline, size: 24),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '${certificate.lastname.toUpperCase()} ${certificate.firstname}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.house_outlined, size: 24),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '${certificate.address.street}, ${certificate.address.zipCode} ${certificate.address.city}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.cake_outlined, size: 24),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '${Utils.dateFormat.format(certificate.birthdate)} à ${certificate.birthplace}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildMovementInformation() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(top: 16),
        color: Utils.hexToColor('#ebebeb'),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Motif de sortie :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: _getMovementActivityIcon(),
                      ),
                      Text(
                        Utils.mapMovementTypeToFrenchHuman(certificate.type),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    Utils.mapMovementTypeToFrenchText(certificate.type),
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildDateInformation() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(top: 16),
        color: Utils.hexToColor('#ebebeb'),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Date et document de sortie :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.access_time_outlined, size: 24),
                      ),
                      Text(
                        '${Utils.dateFormat.format(certificate.creationDateTime)} à '
                        '${Utils.hourFormat.format(certificate.creationDateTime)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                _checkIfSport(),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: RaisedButton.icon(
                            textColor: Colors.white,
                            color: Theme.of(context).accentColor,
                            onPressed: () => {_generateQrcode()},
                            icon: Icon(Icons.qr_code_outlined, size: 22),
                            label: Text(
                              'Voir le QRCODE',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: RaisedButton.icon(
                            textColor: Colors.white,
                            color: Theme.of(context).accentColor,
                            onPressed: () async =>
                                {await PdfGeneration.createPDF(certificate)},
                            icon: Icon(Icons.picture_as_pdf_outlined, size: 22),
                            label: Text(
                              'Voir le PDF',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _getMovementActivityIcon() {
    switch (certificate.type) {
      case MovementType.work:
        return Icon(Icons.work_outline, size: 24);
      case MovementType.shopping:
        return Icon(Icons.shopping_basket_outlined, size: 24);
      case MovementType.medical:
        return Icon(Icons.medical_services_outlined, size: 24);
      case MovementType.family:
        return Icon(Icons.family_restroom_outlined, size: 24);
      case MovementType.handicap:
        return Icon(Icons.wheelchair_pickup_outlined, size: 24);
      case MovementType.sport:
        return Icon(Icons.sports_tennis, size: 24);
      case MovementType.administrative:
        return Icon(Icons.local_police_outlined, size: 24);
      case MovementType.general_interest:
        return Icon(Icons.handyman_outlined, size: 24);
      case MovementType.school:
        return Icon(Icons.escalator_warning_outlined, size: 24);
    }
    return null;
  }

  Widget _checkIfSport() {
    final DateTime creationLimit =
        certificate.creationDateTime.add(new Duration(hours: 1));

    if (certificate.type == MovementType.sport) {
      if (DateTime.now().isAfter(creationLimit)) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                    Icons.warning_amber_outlined,
                    color: Utils.hexToColor('#e1000f'),
                    size: 24
                ),
              ),
              Text(
                "L'heure est dépassée",
                style: TextStyle(
                    fontSize: 16,
                    color: Utils.hexToColor('#e1000f'),
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.timelapse_outlined, size: 24),
            ),
            Text(
              "Il vous reste ${creationLimit.difference(DateTime.now()).inMinutes} minutes",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  _generateQrcode() async {
    final Barcode dm = Barcode.qrCode();
    final String svg = dm.toSvg(
        PdfGeneration.generateValuesFormQrcode(certificate),
        width: 200,
        height: 200
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageDialog(svg);
        });
  }
}