import 'dart:async';

import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Screens/fluidBtmNav.dart';
import 'package:asms/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/PicConstants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  email == null ? Myloginpage() : FluidBottomNav()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(PicConstants.cnergicoLogo),
            Text(
              'Cnergyico',
              style: TextStyle(
                  fontSize: 28,
                  color: Color(ColorConstants.drkGreen1),
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
