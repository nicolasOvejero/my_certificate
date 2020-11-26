import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:my_certificate/certificate.dart';
import 'package:my_certificate/location_service.dart';
import 'package:my_certificate/storage_service.dart';

class MapPage extends StatefulWidget {
  MapPage(this.certificate);

  final Certificate certificate;

  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  static final double RADUIS_VALUE = 1000;

  LatLng _addressPoint = LatLng(0, 0);
  List<Marker> _marker = [];
  MapController _mapController = MapController();
  List<CircleMarker> _circlesMarkers = [];
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Limite autorisée"),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(45.7589, 4.8395669),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(markers: _marker),
          CircleLayerOptions(circles: _circlesMarkers)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      _getPointWithAddress();
    });
  }

  _getPointWithAddress() async {
    _addressPoint.longitude = widget.certificate.address.long;
    _addressPoint.latitude = widget.certificate.address.lat;

    if (widget.certificate.address.long == null &&
        widget.certificate.address.lat == null) {
      _addressPoint = await LocationService.getLongLatFromAddress(
          widget.certificate.address.encodedAddress());
      if (_addressPoint == null) {
        return;
      }
      widget.certificate.address.long = _addressPoint.longitude;
      widget.certificate.address.lat = _addressPoint.latitude;
      await StorageService.storeCertificate(widget.certificate);
    }

    _marker.add(Marker(
      width: 100.0,
      height: 100.0,
      point: _addressPoint,
      builder: (ctx) => Container(
        child: Icon(
            Icons.home,
            size: 26
        ),
      ),
    ));

    _circlesMarkers.add(CircleMarker(
          point: _addressPoint,
          color: Theme.of(_context).primaryColor.withOpacity(0.3),
          borderColor: Theme.of(_context).accentColor.withOpacity(0.3),
          borderStrokeWidth: 1,
          useRadiusInMeter: true,
          radius: RADUIS_VALUE
      )
    );

    _mapController.onReady.then((result) {
      setState(() {
        _mapController.move(_addressPoint, 15.0);
      });
    });
  }
}