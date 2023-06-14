import 'dart:convert';

import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Screens/fluidBtmNav.dart';
import 'package:asms/Widgets.dart/appBarWidget.dart';
import 'package:asms/Widgets.dart/outletCards.dart';
import 'package:asms/model/outletModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RetailOutlets extends StatefulWidget {
  const RetailOutlets({super.key});

  @override
  State<RetailOutlets> createState() => _RetailOutletsState();
}

class _RetailOutletsState extends State<RetailOutlets> {
  List searchedPumps = [];
  String searchString = "";
  List<PetrolPump> pumps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBarWidget(
        context,
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const FluidBottomNav())),
        Icons.arrow_back_ios,
      ),
      body:
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
                children: [
                  txtfield(),
                  /*searchedPumps.isEmpty ?*/
                  Expanded(
                    child: FutureBuilder(
                        future: _getData(),
                        builder: (context, snapshot) {
                          searchedPumps.clear();
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(ColorConstants.drkGreen1),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final splitted =
                                      snapshot.data![index].coordinates.split(',');
                                  return snapshot.data![index].consigneeName.toLowerCase().contains(searchString.toLowerCase()) ? OutletCards(
                                    name: snapshot.data![index].consigneeName,
                                    latt: double.parse(splitted[0]),
                                    longg: double.parse(splitted[1]),
                                  ):
                                  Container();
                                });
                          }
                          else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(ColorConstants.drkGreen1),
                              ),
                            );
                          }
                        }),
                  )
                      /*: Expanded(
                    child: ListView.builder(
                      itemCount: searchedPumps.length,
                      itemBuilder: (ctx,i){
                        print(searchedPumps.length);
                        final splitted = searchedPumps[i].coordinates.split(',');
                        return OutletCards(name: searchedPumps[i].consigneeName, latt: double.parse(splitted[0]),longg: double.parse(splitted[1]),);
                      },
                    ),
                  )*/
                ],
              ),
            ),
    );
  }

  Future<List<PetrolPump>> _getData() async {
    var url = Uri.parse(
        'http://151.106.17.246:8080/byco/api/geolist.php?accesskey=12345');
    http.get(url).then((data) {
      return json.decode(data.body);
    }).then((data) {
      for (var json in data) {
        pumps.add(PetrolPump.fromJson(json));
      }
    }).catchError((e) {
      print(e);
    });
    var client = http.Client();
    var response = await client.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PetrolPump.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  txtfield(){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: double.infinity,
      color: Colors.grey[200],
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          cursorColor: Color(ColorConstants.drkGreen1),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(ColorConstants.drkGreen1)),
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
              hintText: 'Search'),
          onChanged: (text){
            setState((){
              searchString = text;
              // print(searchString);
            });
            /*searchedPumps.clear();
            if (text.isEmpty) {
              setState(() {});
              return;
            }
            for (var data in pumps) {
              if (data.consigneeName
                  .toLowerCase()
                  .contains(text.toLowerCase())) {

                if (searchedPumps.contains(data)) {
                  return;
                }
                else {
                  searchedPumps.add(data);
                }
              }
            }
            setState(() {});*/
          },
        ),
      ),);
  }
}
