import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'certificate.dart';

class Utils {
  static final dateFormat = DateFormat("dd/MM/yyyy");
  static final hourFormat = DateFormat("HH:mm");

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static String mapMovementTypeToFrench(MovementType type) {
    switch (type) {
      case MovementType.work:
        return "travail";
      case MovementType.shopping:
        return "achats";
      case MovementType.medical:
        return "sante";
      case MovementType.family:
        return "famille";
      case MovementType.handicap:
        return "handicap";
      case MovementType.sport:
        return "sport_animaux";
      case MovementType.administrative:
        return "convocation";
      case MovementType.general_interest:
        return "missions";
      case MovementType.school:
        return "enfants";
    }
    return "";
  }

  static String mapMovementTypeToFrenchHuman(MovementType type) {
    switch (type) {
      case MovementType.work:
        return "Travail";
      case MovementType.shopping:
        return "Achats pro./première nécessité";
      case MovementType.medical:
        return "Consultations/examens/soins";
      case MovementType.family:
        return "Déplacements motif impérieux";
      case MovementType.handicap:
        return "Handicap et accompagnant";
      case MovementType.sport:
        return "Activité physique/Animaux de compagnie";
      case MovementType.administrative:
        return "Convocation judiciaire/administrative";
      case MovementType.general_interest:
        return "Missions d'intérêt général";
      case MovementType.school:
        return "Déplacement pour enfants";
    }
    return "";
  }

  static String mapMovementTypeToFrenchText(MovementType type) {
    switch (type) {
      case MovementType.work:
        return "Déplacements entre le domicile et le lieu d'exercice "
            "de l'activité professionnelle ou un établissement d'enseignement ou "
            "de formation, déplacements professionnels ne pouvant être différés, "
            "déplacements pour un concours ou un examen.";
      case MovementType.shopping:
        return "Déplacements pour effectuer des achats de "
            "fournitures nécessaires à l'activité professionnelle, "
            "des achats de première nécessité dans des établissements "
            "dont les activités demeurent autorisées, le retrait de "
            "commande et les livraisons à domicile.";
      case MovementType.medical:
        return "Consultations, examens et soins ne pouvant être "
            "assurés à distance et l'achat de médicaments.";
      case MovementType.family:
        return "Déplacements pour motif familial impérieux, pour "
            "l'assistance aux personnes vulnérables et précaires ou la garde d'enfants.";
      case MovementType.handicap:
        return "Déplacement des personnes en situation "
            "de handicap et leur accompagnant.";
      case MovementType.sport:
        return "Déplacements brefs, dans la limite d'une heure quotidienne et dans "
            "un rayon maximal d'un kilomètre autour du domicile, liés soit à l'activité "
            "physique individuelle des personnes, à l'exclusion de toute pratique "
            "sportive collective et de toute proximité avec d'autres personnes, soit à la "
            "promenade avec les seules personnes regroupées dans un même domicile, "
            "soit aux besoins des animaux de compagnie.";
      case MovementType.administrative:
        return "Convocation judiciaire ou administrative et"
            " pour se rendre dans un service public.";
      case MovementType.general_interest:
        return "Participation à des missions d'intérêt général"
            " sur demande de l'autorité administrative.";
      case MovementType.school:
        return "Déplacement pour chercher les enfants à "
            "l'école et à l'occasion de leurs activités périscolaires.";
    }
    return "";
  }
}
