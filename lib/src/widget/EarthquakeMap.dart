import 'package:earthquake_app/src/utils/AreaForecastLocalELocation.dart';
import 'package:earthquake_app/src/widget/createProgressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/AreaInformationCityLocation.dart';
import '../utils/ParseIntImage.dart';

class EarthquakeMap extends StatefulWidget {
  dynamic data;
  EarthquakeMap({super.key, required this.data});

  @override
  State<EarthquakeMap> createState() => _EarthquakeMapState();
}

// Stateを継承して使う
class _EarthquakeMapState extends State<EarthquakeMap> {
  dynamic data;
  var hypoLat;
  var hypoLng;
  List<Marker> markers = [];
  var hypoMarker;
  List<Marker> cityMarkers = [];
  List<Marker> areaMarkers = [];
  List<LatLng> latlngPoints = [];
  var bounds;

  bool zoomArea = true;

  @override
  void setMapView(zoom) {
    if (zoom > 8) {
      if (zoomArea == true) return;
      zoomArea = true;
      setState(() {
        markers = [];
        markers.add(hypoMarker);
        markers.addAll(cityMarkers);
      });
    } else {
      if (zoomArea == false) return;
      zoomArea = false;
      setState(() {
        markers = [];
        markers.add(hypoMarker);
        markers.addAll(areaMarkers);
      });
    }
  }

  List<List<dynamic>> areaIntCategory = [[],[],[],[],[],[],[],[],[]];
  List<List<dynamic>> cityIntCategory = [[],[],[],[],[],[],[],[],[]];


  void setMapData() async {
    data = widget.data;
    if (data["Body"]["Earthquake"] != null) {
      hypoLat =
          double.parse(data["Body"]["Earthquake"]["Hypocenter"]["Latitude"]);
      hypoLng =
          double.parse(data["Body"]["Earthquake"]["Hypocenter"]["Longitude"]);
      LatLng point = LatLng(hypoLat, hypoLng);
      latlngPoints.add(point);
      hypoMarker = Marker(
        point: point,
        width: 40,
        height: 40,
        builder: (ctx) =>
            Container(
              child: Image.asset('assets/hypo.png', fit: BoxFit.contain),
            ),
      );
      markers.add(hypoMarker);
    } else {
      hypoLat = 35.7102;
      hypoLng = 139.8132;
    }
    if (data["Body"]["Intensity"] != null) {
      for (var pref in data["Body"]["Intensity"]["Observation"]["Pref"]) {
        for (var area in pref["Area"]) {
          List<double>? getAreaLocation = AreaForecastLocalELocation(area["Code"]);
          if (getAreaLocation != null) {
            LatLng areaPoint = LatLng(getAreaLocation![0], getAreaLocation![1]);
            String maxAreaIntInt = ParseIntImage(area["MaxInt"]);
            latlngPoints.add(areaPoint);
            areaIntCategory[int.parse(maxAreaIntInt)].add(Marker(
              point: areaPoint,
              width: 30,
              height: 30,
              builder: (ctx) =>
                  Container(
                    child: Image.asset(
                        "assets/int/int$maxAreaIntInt.png",
                        fit: BoxFit.contain),
                  ),
            ));
            if (area["City"] != null) {
              for (var city in area["City"]) {
                List<double>? getCityLocation = AreaInformationCityLocation(
                    city["Code"]);
                if (getCityLocation != null) {
                  LatLng cityPoint = LatLng(getCityLocation![0], getCityLocation![1]);
                  String maxCityIntInt = ParseIntImage(city["MaxInt"]);
                  cityIntCategory[int.parse(maxCityIntInt)].add(Marker(
                    point: cityPoint,
                    width: 25,
                    height: 25,
                    builder: (ctx) =>
                        Container(
                          child: Image.asset(
                              "assets/int/int_s$maxCityIntInt.png",
                              fit: BoxFit.contain),
                        ),
                  ));
                }
              }
            }
          }
        }
      }
    }
    for (var i = 0; i < 9; i++) {
      for (var area in areaIntCategory[i]) {
        areaMarkers.add(area);
      }
      for (var city in cityIntCategory[i]) {
        cityMarkers.add(city);
      }
    }
    markers.addAll(areaMarkers);
    LatLngBounds bounds1 = LatLngBounds.fromPoints(latlngPoints);
    LatLng sw = bounds1.southWest;
    LatLng ne = bounds1.northEast;
    bounds = LatLngBounds(LatLng(sw.latitude - 0.2, sw.longitude - 0.2), LatLng(ne.latitude + 0.2, ne.longitude + 0.2));
  }

  @override
  void initState() {
    super.initState();
    setMapData();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) return createProgressIndicator();
    return
      Container(
        alignment: Alignment.centerLeft,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(hypoLat, hypoLng!),
            zoom: 5,
            maxZoom: 12,
            minZoom: 4,
            bounds: bounds,
            onPositionChanged: (position, bo) {
              setMapView(position.zoom);
            },
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.doubleTapZoom,
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
}