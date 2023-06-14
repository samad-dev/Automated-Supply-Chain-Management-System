import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Constants/PicConstants.dart';
import 'package:asms/Screens/activePlansmap.dart';
import 'package:flutter/material.dart';

class ActivePlanCard extends StatelessWidget {
  var cusname;
  var vehName;
  var depot;
  var product;
  var quantity;
  var time;
  int diff;
  var id;
  var coPoints;
  ActivePlanCard({
    super.key,
    required this.cusname,
    required this.vehName,
    required this.depot,
    required this.product,
    required this.quantity,
    required this.time,
    required this.diff,
    required this.id,
    required this.coPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: diff >= 0
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivePlansMap(
                              points: coPoints,
                              id: id,
                              qty: quantity,
                              prod: product,
                              pumpname: cusname,
                            )));
              }
            : () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Not Reporting',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                    color: Color(ColorConstants.drkGreen1)),
                              ))
                        ],
                      );
                    });
              },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        tileColor: Colors.white,
        leading: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      diff >= 0
                          ? Color(ColorConstants.drkGreen1).withOpacity(.9)
                          : Color(0xff9a0606).withOpacity(0.9),
                      diff >= 0
                          ? Color(ColorConstants.drkGreen1).withOpacity(.65)
                          : Color(0xff9a0606).withOpacity(0.65),
                      diff >= 0
                          ? Color(ColorConstants.drkGreen2).withOpacity(.65)
                          : Color(0xff9a0606).withOpacity(0.65),
                      diff >= 0
                          ? Color(ColorConstants.drkGreen2).withOpacity(.9)
                          : Color(0xff9a0606).withOpacity(0.9),
                    ])),
            child: Image.asset(
              PicConstants.tankTruck,
            )),
        trailing: SizedBox(
            child: RichText(
          text: TextSpan(
            text: 'Product: $product',
            style: const TextStyle(
                fontFamily: 'display-sans-serif',
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.grey),
            children: [
              TextSpan(
                text: '\nQuantity: $quantity',
                style: const TextStyle(
                    fontFamily: 'display-sans-serif',
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.grey),
              ),
              diff >= 0
                  ? TextSpan(text: '')
                  : TextSpan(
                      text: '\nNR',
                      style: const TextStyle(
                          // fontFamily: 'display-sans-serif',
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.grey),
                    )
            ],
          ),
        )),
        title: SizedBox(
          child: Text(
            cusname,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        subtitle: SizedBox(
            child: RichText(
          text: TextSpan(
            text: vehName,
            style: const TextStyle(
                fontFamily: 'display-sans-serif',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey),
            children: [
              TextSpan(
                text: '\nDepot: $depot',
                style: const TextStyle(
                    fontFamily: 'display-sans-serif',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.grey),
              ),
              TextSpan(
                text: '\nTrip start Date: $time',
                style: const TextStyle(
                    fontFamily: 'display-sans-serif',
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                    color: Colors.grey),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
