import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Constants/PicConstants.dart';
import 'package:flutter/material.dart';

appBarWidget(context, func, icn) {
  return AppBar(
    actions: [
      IconButton(
          onPressed: func,
          icon: Icon(
            icn,
            color: Color(ColorConstants.drkGreen1),
          ))
    ],
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    title: Row(
      children: [
        Image(
          image: AssetImage(PicConstants.cnergicoLogo),
          height: 35,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Cnergyico',
          style: TextStyle(
              fontSize: 25,
              color: Color(ColorConstants.drkGreen1),
              fontWeight: FontWeight.w900),
        ),
      ],
    ),
  );
}

mainAppBar(context, func, icn) {
  return AppBar(
    actions: [
      IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        'Do you want to Logout?',
                        style: TextStyle(
                            color: Color(ColorConstants.drkGreen1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    actions: [
                      Align(
                  alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: func,
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(ColorConstants.drkGreen1)),
                            child: const Text(
                              "Log out",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  Align(
                  alignment: Alignment.center,
                  child:GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(15),

                          alignment: Alignment.center,
                          width: 150,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(ColorConstants.drkGreen1),
                            ),
                          ),
                        ),
                      ),
                  )
                    ],
                  );
                });
          },
          icon: Icon(
            icn,
            color: Color(ColorConstants.drkGreen1),
          ))
    ],
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    title: Row(
      children: [
        Image(
          image: AssetImage(PicConstants.cnergicoLogo),
          height: 35,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Cnergyico',
          style: TextStyle(
              fontSize: 25,
              color: Color(ColorConstants.drkGreen1),
              fontWeight: FontWeight.w900),
        ),
      ],
    ),
  );
}
