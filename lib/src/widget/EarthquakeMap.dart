import 'package:earthquake_app/src/utils/AreaForecastLocalELocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/ParseIntImage.dart';

Widget EarthquakeMap(data) {
  double hypoLat;
  double hypoLng;
  List<Marker> markers = [];
  List<Marker> prefMarkers = [];

  if (!data["Body"]["Earthquake"].isEmpty) {
    hypoLat = double.parse(data["Body"]["Earthquake"]["Hypocenter"]["Latitude"]);
    hypoLng = double.parse(data["Body"]["Earthquake"]["Hypocenter"]["Longitude"]);
    markers.add(Marker(
      point: LatLng(hypoLat, hypoLng),
      width: 40,
      height: 40,
      builder: (ctx) => Container(
        child: Image.asset('assets/hypo.png',fit: BoxFit.contain),
      ),
    ));
  } else {
    hypoLat = 35.7102;
    hypoLng = 139.8132;
  }
  if (!data["Body"]["Intensity"].isEmpty) {
    for (var pref in data["Body"]["Intensity"]["Observation"]["Pref"]) {
        for (var pref in pref["Area"]) {
          List<double>? getLocation = AreaForecastLocalELocation(pref["Code"]);
          if (getLocation == null) continue;
          prefMarkers.add(Marker(
            point: LatLng(getLocation![0], getLocation![1]),
            width: 30,
            height: 30,
            builder: (ctx) => Container(
              child: Image.asset("assets/int/int_s${ParseIntImage(pref["MaxInt"])}.png",fit: BoxFit.contain),
            ),
          ));
      }
    }
  }
  markers.addAll(prefMarkers);
  return
    Container(
      alignment: Alignment.centerLeft,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(hypoLat, hypoLng),
          zoom: 5
        ),
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'net.narikakun.flutterearthquakeapp',
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      )
    );
}