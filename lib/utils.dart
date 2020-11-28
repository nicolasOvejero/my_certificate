import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'certificate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  static String mapMovementTypeToFrenchText(MovementType type, BuildContext context) {
    switch (type) {
      case MovementType.work:
        return AppLocalizations.of(context).movementFormWorkExp;
      case MovementType.shopping:
        return AppLocalizations.of(context).movementFormShoppingExp;
      case MovementType.medical:
        return AppLocalizations.of(context).movementFormMedicalExp;
      case MovementType.family:
        return AppLocalizations.of(context).movementFormFamilyExp;
      case MovementType.handicap:
        return AppLocalizations.of(context).movementFormHandicapExp;
      case MovementType.sport:
        return AppLocalizations.of(context).movementFormSportExp;
      case MovementType.administrative:
        return AppLocalizations.of(context).movementFormAdministrativeExp;
      case MovementType.general_interest:
        return AppLocalizations.of(context).movementFormGeneralInterestExp;
      case MovementType.school:
        return AppLocalizations.of(context).movementFormSchoolExp;
    }
    return "";
  }
}
