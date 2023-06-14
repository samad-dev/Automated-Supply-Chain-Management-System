// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:asms/Screens/login.dart';
import 'package:asms/Widgets.dart/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/PicConstants.dart';
import '../Services/getOutlets.dart';
import '../model/outletModel.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late List<Marker> markers = [];
  late Future<List<Marker>> markers2;
  final LatLng center = const LatLng(24.946218, 67.005615);
  late List<PetrolPump> futureData;

  void _onMapCreated(GoogleMapController controller) async {
    futureData = await getData();
    markers.clear();
    for (int i = 0; i < futureData.length; i++) {
      final splitted = futureData[i].coordinates.split(',');
      // print(splitted[0]);
      setState(() {
        markers.add(Marker(
          icon: icnn,
          infoWindow: InfoWindow(title: futureData[i].consigneeName),
          markerId: MarkerId(futureData[i].id),
          position:
              LatLng(double.parse(splitted[0]), double.parse(splitted[1])),
        ));
      });
    }

    mapController = controller;
  }

  late BitmapDescriptor icnn;
  @override
  void initState() {
    getIcons();
    super.initState();
  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio:  5, size: Size.square(20)),
        PicConstants.pumpMarker);
    setState(() {
      icnn = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar(
          context,
          () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => Myloginpage())));
          },
          Icons.exit_to_app,
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return Center(
                child: GoogleMap(
                  markers: Set<Marker>.of(markers),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: center,
                    zoom: 11.0,
                  ),
                ),
              );
            }));
  }
}
