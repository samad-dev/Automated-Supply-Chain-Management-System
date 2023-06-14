import 'dart:io';
import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Constants/PicConstants.dart';
import 'package:asms/Screens/fluidBtmNav.dart';
import 'package:asms/Widgets.dart/appBarWidget.dart';
import 'package:flutter/services.dart';
import 'package:asms/Widgets.dart/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}
String? email;


class _ProfileState extends State<Profile> {

  @override
  void initState() {
    getName().then((val) {
      setState(() {});
      print("success");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
    // getName();
    super.initState();
  }


  getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email',)!;
    return email;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBarWidget(
        context,
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FluidBottomNav())),
        Icons.arrow_back_ios,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(ColorConstants.drkGreen1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Welcome',
                    style: TextStyle(
                        fontFamily: 'display-sans-serif',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: '\n${email}',
                    style: TextStyle(
                        fontFamily: 'display-sans-serif',
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Colors.white),
                  )
                ])),
                CircleAvatar(
                  backgroundColor: Colors.white,
                            radius: 40,
                            child: Image.asset(PicConstants.cnergicoLogo),
                          )
                        
              ],
            ),
          ),
          Expanded(
            child: ListView(children: [
              ProfileTile(
                onTapFunc: (){},
                iconn: Icons.edit_outlined,
                txt: 'Edit Profile',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(
                  color: Color(ColorConstants.drkGreen1),
                ),
              ),
              ProfileTile(
                onTapFunc: (){},
                iconn: Icons.key_outlined,
                txt: 'Change Password',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(
                  color: Color(ColorConstants.drkGreen1),
                ),
              ),
              ProfileTile(
                onTapFunc: () {
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
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.remove('email');
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: ((context) => Myloginpage())));
                                },
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
                              child: GestureDetector(
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
                iconn: Icons.logout,
                txt: 'Log Out',
              ),
            ]),
          )
        ],
      ),
    );
  }
}
