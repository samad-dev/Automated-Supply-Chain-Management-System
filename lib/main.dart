
import 'package:asms/Screens/login.dart';
import 'package:asms/Screens/splash.dart';
import 'package:asms/utils/navProvider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/fluidBtmNav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'display-sans-serif'),
    debugShowCheckedModeBanner: false,
    home: SplashScreen()
  ),);
}

