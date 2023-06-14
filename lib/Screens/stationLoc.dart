import 'package:asms/Widgets.dart/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/PicConstants.dart';

class LocationMap extends StatefulWidget {
  LocationMap({super.key, required this.latt, required this.longg, required this.name});
  double latt, longg;
  String name;

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
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
        ImageConfiguration(devicePixelRatio:  5, size: Size.square(20)),
        PicConstants.pumpMarker);
    setState(() {
      this.icnn = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer:  NavigationDrawerWidget(),
        appBar:  appBarWidget(
          context,
          () => Navigator.pop(context),
          Icons.arrow_back_ios,
        ),
        body: Center(
          child: GoogleMap(
            markers: <Marker>{
               Marker(
                 infoWindow: InfoWindow(title: widget.name,),
                   icon: icnn,

                   markerId: const MarkerId('1'),
                  position:  LatLng(widget.latt, widget.longg))
            },
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latt, widget.longg),
              zoom: 15.0,
            ),
          ),
        ));
  }
}
