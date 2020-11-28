import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibModel {
  String name;
  String description;
  String link;

  LibModel(this.name, this.description, this.link);
}

class CreditPage extends StatefulWidget {
  CreditPage();

  @override
  _CreditPage createState() => _CreditPage();
}

class _CreditPage extends State<CreditPage> {
  final List<LibModel> libs = [
    LibModel("pdf", "Utilisée pour la création du pdf",
        "https://pub.dev/packages/pdf (nfet.net)"),
    LibModel("open_file", "Utilisée pour l'ouverture du pdf",
        "https://pub.dev/packages/open_file (crazecoder)"),
    LibModel(
        "datetime_picker_formfield",
        "Utilisée pour les champs du formulaire",
        "https://pub.dev/packages/datetime_picker_formfield (jifalops)"),
    LibModel("barcode", "Utilisée pour générer le QRcode",
        "https://pub.dev/packages/barcode (nfet.net)"),
    LibModel("flutter_svg", "Utilisée pour afficher le QRcode généré",
        "https://pub.dev/packages/flutter_svg (dnfield)"),
    LibModel("geolocator", "Utilisée pour avoir la position de l'utilisateur",
        "https://pub.dev/packages/geolocator (baseflow)"),
    LibModel(
        "flutter_map",
        "Utilisée pour afficher la carte avec la limite de autorisé",
        "https://pub.dev/packages/flutter_map (jpryan)"),
    LibModel(
        "flutter_launcher_icons",
        "Utilisée pour changer l'icon de l'application",
        "https://pub.dev/packages/flutter_map (jpryan)"),
    LibModel(
        "path_provider",
        "Utilisée pour avoir le chemin pour stocker l'attestation",
        "https://pub.dev/packages/path_provider (flutter)"),
    LibModel(
        "shared_preferences",
        "Utilisée pour stocker en local le information renseigner",
        "https://pub.dev/packages/shared_preferences (flutter)"),
    LibModel("intl", "Utilisée pour les variables de langue",
        "https://pub.dev/packages/intl (dart)"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information et contact"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildLibView(context)],
        ),
      ),
    );
  }

  Widget _buildLibView(BuildContext context) {
    final List<Widget> libView = [
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          AppLocalizations.of(context).creditLibTitle,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 24,
              fontWeight: FontWeight.w900),
        ),
      ),
    ];
    libView.addAll(libs.map((LibModel lib) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${lib.name} : ${lib.description}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: SelectableText(
              lib.link,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          libs.indexOf(lib) >= libs.length - 1
              ? Container()
              : Divider(thickness: 2),
        ],
      );
    }));

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: libView),
    );
  }
}
