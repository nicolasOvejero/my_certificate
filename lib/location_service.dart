import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:my_certificate/certificate.dart';

class LocationService {
  static const String BASE_NOMINATIM_URL =
      'https://nominatim.openstreetmap.org';

  static Future<Address> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return getPosition();
    }

    return Address(null, null, null);
  }

  static Future<Address> getPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return Address(null, null, null);
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return getAddressValues(position.longitude, position.latitude);
  }

  static Future<Address> getAddressValues(double long, double lat) async {
    http.Response rep = await http
        .get('$BASE_NOMINATIM_URL/reverse?format=json&lat=$lat&lon=$long');
    if (rep.body.isEmpty) {
      return Address(null, null, null);
    }

    dynamic values = json.decode(rep.body);
    return Address(
        values['address']['city'],
        '${values['address']['house_number']} ${values['address']['road']}',
        values['address']['postcode']);
  }
}
