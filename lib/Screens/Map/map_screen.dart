import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:zanimo/constants.dart';
import 'package:zanimo/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var new_long = "";
var new_lat = "";

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final Completer<GoogleMapController> _controller = Completer();
  String collierLong = "";
  String collierLat = "";
  String latitude = SimplePreferences().getLatitude();
  String longitude = SimplePreferences().getLongitude();
  static LatLng sourceLocation = LatLng(48.35849038788923, -4.5702318364295875);
  // LatLng(double.parse(longitude_global), double.parse(latitude_global));
  static LatLng destination = LatLng(48.360086156462536, -4.56596187803809);

  List<LatLng> polylineCoordinates = [];
  List<Marker> myMarker = [];
  List<Polyline> myPolyline = [];

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/location.png")
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/location.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/dog.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  void getPolyPoints() async {
    final resp = await http.get(Uri.parse('http://192.168.126.234:5000/'));
    final dec = json.decode(resp.body) as Map<String, dynamic>;
    final longi = double.parse(dec['longitude']);
    final lati = double.parse(dec['latitude']);
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      '', // Your Google Map Key
      PointLatLng(LatLng(longi, lati).latitude, LatLng(longi, lati).longitude),
      PointLatLng(double.parse(SimplePreferences().getLatitude()),
          double.parse(SimplePreferences().getLongitude())),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void majPolyPoints(url) async {
    final resp = await http.get(url);
    final dec = json.decode(resp.body) as Map<String, dynamic>;
    final longi = double.parse(dec['longitude']);
    final lati = double.parse(dec['latitude']);
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      '', // Your Google Map Key
      PointLatLng(LatLng(longi, lati).latitude, LatLng(longi, lati).longitude),
      PointLatLng(double.parse(SimplePreferences().getLatitude()),
          double.parse(SimplePreferences().getLongitude())),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates = [];
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
    setState(() {
      myPolyline[0] = Polyline(
        polylineId: const PolylineId("route"),
        points: polylineCoordinates,
        color: const Color(0xFF7B61FF),
        width: 6,
      );
    });
  }

  @override
  void initState() {
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();

    longitude = SimplePreferences().getLongitude();
    latitude = SimplePreferences().getLatitude();
    myMarker.add(
      Marker(
          markerId: MarkerId("Source"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(double.parse(latitude), double.parse(longitude)),
          infoWindow: InfoWindow(
              title: 'Point de référence', snippet: '$latitude , $longitude')),
    );

    myPolyline.add(Polyline(
      polylineId: const PolylineId("route"),
      points: polylineCoordinates,
      color: const Color(0xFF7B61FF),
      width: 6,
    ));

    _getCollierCoords(Uri.parse('http://192.168.126.234:5000/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: kPrimaryColor),
        onPressed: () async {
          await SimplePreferences.setLatitude(double.parse(new_lat));
          await SimplePreferences.setLongitude(double.parse(new_long));
        },
        child: const Text('Enregistrer Repère'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(latitude), double.parse(longitude)),
          zoom: 16,
        ),
        polylines: Set.from(myPolyline),
        circles: {
          Circle(
            circleId: CircleId("1"),
            center: LatLng(double.parse(latitude), double.parse(longitude)),
            strokeColor: Color.fromARGB(255, 255, 0, 0),
            radius: 100,
            strokeWidth: 2,
            fillColor: kPrimaryColor.withOpacity(0.2),
          )
        },
        markers: Set.from(myMarker),
        onTap: _handleTap,
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    new_lat = tappedPoint.latitude.toString();
    new_long = tappedPoint.longitude.toString();

    setState(() {
      myMarker[0] = Marker(
          markerId: MarkerId(tappedPoint.toString()), position: tappedPoint);
    });
  }

  _getCollierCoords(url) async {
    final response = await http.get(url);
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    print(decoded);
    collierLong = decoded['longitude'].toString();
    collierLat = decoded['latitude'].toString();
    myMarker.add(
      Marker(
          markerId: MarkerId("Destination"),
          icon: destinationIcon,
          position: LatLng(double.parse(collierLong), double.parse(collierLat)),
          infoWindow: InfoWindow(
              title: 'Position du collier',
              snippet: '$collierLong , $collierLat')),
    );
    Timer.periodic(Duration(seconds: 1), (timer) {
      _majCollierCoords(url);
      majPolyPoints(url);
    });
  }

  _majCollierCoords(url) async {
    final response = await http.get(url);
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    collierLong = decoded['longitude'].toString();
    collierLat = decoded['latitude'].toString();
    setState(() {
      myMarker[1] = Marker(
          markerId: MarkerId("Destination"),
          icon: destinationIcon,
          position: LatLng(double.parse(collierLong), double.parse(collierLat)),
          infoWindow: InfoWindow(
              title: 'Position du collier',
              snippet: '$collierLong , $collierLat'));
    });
  }
}
