import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Screens/stationLoc.dart';
import 'package:flutter/material.dart';

class OutletCards extends StatelessWidget {
  var name;
  var latt;
  var longg;
   OutletCards({super.key, required this.name, required this.latt, required this.longg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => LocationMap(latt: latt, longg: longg, name: name,))));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(10),
        tileColor: Colors.white,
        title: Center(
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,
                color: Color(ColorConstants.drkGreen1)),
          ),
        ),
      ),
    );
  }
}
