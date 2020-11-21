import 'package:flutter/material.dart';

import 'certificate.dart';
import 'certificate_form.dart';

class TabBarController extends StatefulWidget {
  TabBarController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabBarController createState() => _TabBarController();
}

class _TabBarController extends State<TabBarController> {
  Certificate certificate = new Certificate();

  @override
  Widget build(BuildContext context) {
    certificate.lastname = "Ovejero";
    certificate.firstname = "Nicolas";
    certificate.birthdate = DateTime(1995, 07, 15);
    certificate.birthplace = "Nantua";
    certificate.address = new Address();
    certificate.address.city = "Villeurbanne";
    certificate.address.zipCode = "69100";
    certificate.address.street = "106 Boulevard du 11 Novembre 1918";
    certificate.type = MovementType.work;
    certificate.creationDateTime = DateTime.now();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Nouvelle attestation',
                icon: Icon(
                  Icons.border_color,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: 'Mes attestations',
                icon: Icon(
                  Icons.insert_drive_file_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: [
            Container(
                padding: EdgeInsets.all(16),
                child: new SingleChildScrollView(
                    child: new Column(children: <Widget>[
                      CertificateForm(certificate)
                    ])
                )
            ),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
