import 'dart:convert';

import 'package:my_certificate/models/certificate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<Certificate> getStoredCertificate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String prefValues = prefs.getString('certificate');
    Certificate certificate;

    if (prefValues == null) {
      certificate = new Certificate();
      certificate.address = new Address(null, null, null);
    } else {
      certificate = Certificate.fromJson(json.decode(prefs.getString('certificate')));
    }

    return certificate;
  }

  static Future<void> storeCertificate(final Certificate certificate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('certificate', json.encode(certificate.toJson()));
  }

}
