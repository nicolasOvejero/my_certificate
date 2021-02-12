import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/certificate.dart';
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
      case MovementType.transit:
        return "transits";
      case MovementType.animals:
        return "animaux";
    }
    return "";
  }

  static String mapMovementTypeToFrenchHuman(MovementType type, BuildContext context) {
    switch (type) {
      case MovementType.work:
        return AppLocalizations.of(context).workTitle;
      case MovementType.shopping:
        return AppLocalizations.of(context).shoppingTitle;
      case MovementType.medical:
        return AppLocalizations.of(context).medicalTitle;
      case MovementType.family:
        return AppLocalizations.of(context).familyTitle;
      case MovementType.handicap:
        return AppLocalizations.of(context).handicapTitle;
      case MovementType.sport:
        return AppLocalizations.of(context).sportTitle;
      case MovementType.administrative:
        return AppLocalizations.of(context).administrativeTitle;
      case MovementType.general_interest:
        return AppLocalizations.of(context).generalInterestTitle;
      case MovementType.school:
        return AppLocalizations.of(context).schoolTitle;
      case MovementType.transit:
        return AppLocalizations.of(context).transitTitle;
      case MovementType.animals:
        return AppLocalizations.of(context).animalTitle;
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
      case MovementType.transit:
        return AppLocalizations.of(context).movementFormTransitExp;
      case MovementType.animals:
        return AppLocalizations.of(context).movementFormAnimalExp;
    }
    return "";
  }
}
