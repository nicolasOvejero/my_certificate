import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
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
        values['address']['postcode'],
        long: long,
        lat: lat);
  }

  static Future<LatLng> getLongLatFromAddress(String address) async {
    http.Response rep =
        await http.get('$BASE_NOMINATIM_URL/search?format=json&q=$address');
    if (rep.body.isEmpty) {
      return null;
    }

    dynamic values = json.decode(rep.body);

    if (values == []) {
      return null;
    }

    return LatLng(
        double.parse(values[0]['lat']), double.parse(values[0]['lon']));
  }
}
