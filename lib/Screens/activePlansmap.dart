import 'dart:convert';

import 'package:asms/Widgets.dart/appBarWidget.dart';
import 'package:asms/model/tripRouteModel.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../Constants/PicConstants.dart';

class ActivePlansMap extends StatefulWidget {
  var id;
  var qty;
  var prod;
  var points;
  var pumpname;
  ActivePlansMap({
    super.key,
    required this.id,
    required this.qty,
    required this.prod,
    required this.points,
    required this.pumpname,
  });

  @override
  State<ActivePlansMap> createState() => _ActivePlansMapState();
}

class _ActivePlansMapState extends State<ActivePlansMap> {
  late GoogleMapController mapController;
  final Set<Polyline> _polyline = {};
  List<LatLng> latlng = [];
  String name = "";
  String product = "";
  String quantity = "";
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  double start_lat = 0.0, end_lat = 0.0;
  double start_lng = 0.0, end_lng = 0.0;
  late BitmapDescriptor icnn;
  late BitmapDescriptor pumpicon;


  @override
  void initState() {
    // super.initState();
    getTripRoutes();
    getIcons();
    getpumpicons();
  }

  @override
  Widget build(BuildContext context) {
    List splitter =
        widget.points != "" ? (widget.points).split(',') : ["0", "0"];
    return Scaffold(
        appBar: appBarWidget(
          context,
          () => Navigator.pop(context),
          Icons.arrow_back_ios,
        ),
        body: Stack(
          children: [
            Center(
              child: GoogleMap(
                markers: <Marker>{
                  Marker(
                    icon: icnn,
                    infoWindow: InfoWindow(title: name),
                    markerId: const MarkerId('1'),
                    position: LatLng(start_lat, start_lng),
                  ),
                       Marker(
                          markerId: MarkerId('2'),
                          position: LatLng(double.parse(splitter[0]),
                              double.parse(splitter[1])),
                          infoWindow: InfoWindow(title: widget.points != "" ? widget.pumpname : 'No Info Provided'),
                          icon: pumpicon,
                        )
                      },
                onMapCreated: (GoogleMapController controller) async {
                  _customInfoWindowController.googleMapController = controller;
                },
                polylines: _polyline,
                initialCameraPosition: CameraPosition(
                  target: LatLng(30.3753, 69.3451),
                  zoom: 5.0,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 5,
              child: Container(
                color: Colors.white,
                width: 180,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Vehicle Name: $name'),
                    Text('Product: ${widget.prod}'),
                    Text('Quantity: ${widget.qty}'),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Future<List<TripRoute>> getTripRoutes() async {
    var client = http.Client();
    // plans.clear();
    var url = Uri.parse(
        'http://151.106.17.246:8080/byco/api/triproute.php?accesskey=12345&vehicle=${widget.id}&initial=2022-09-19%2016:42:57');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        latlng.add(LatLng(double.parse(jsonResponse[i]['latitude']),
            double.parse(jsonResponse[i]['longitude'])));
        i++;
      }
      setState(() {
        name = jsonResponse[0]['vehicle_id'];
        start_lat = double.parse(jsonResponse[0]['latitude']);
        start_lng = double.parse(jsonResponse[0]['longitude']);
        end_lat = double.parse(jsonResponse[0]['latitude']);
        end_lng = double.parse(jsonResponse[0]['longitude']);
        _polyline.add(Polyline(
          polylineId: PolylineId("poly"),
          visible: true,
          points: latlng,
          color: Colors.red,
        ));
      });
      return jsonResponse.map((data) => TripRoute.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  getpumpicons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5, size: Size.square(20)),
        PicConstants.pumpMarker);
    setState(() {
      pumpicon = icon;
    });
  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5, size: Size.square(20)),
        PicConstants.tankerMarker);
    setState(() {
      icnn = icon;
    });
  }
}
