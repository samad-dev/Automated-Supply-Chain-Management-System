import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Screens/profile.dart';
import 'package:asms/Screens/activePlans.dart';
import 'package:asms/Screens/map.dart';
import 'package:asms/Screens/retailOutlets.dart';
import 'package:flutter/material.dart';

class FluidBottomNav extends StatefulWidget {
  const FluidBottomNav({super.key});

  @override
  State<FluidBottomNav> createState() => _FluidBottomNavState();
}

class _FluidBottomNavState extends State<FluidBottomNav> {
  int selected = 0;
  List pages = [MapScreen(), ActivePlansPage(), RetailOutlets(), Profile()];
  void onItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(selected),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(ColorConstants.drkGreen2),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on,
              ),
              label: 'Map'),
              
          BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              label: 'Active Plans'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_gas_station,
              ),
              label: 'Retail Outlet'),
              
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
        currentIndex: selected,
        onTap: onItemTapped,
      ),
    );
  }
}
