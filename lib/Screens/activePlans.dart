import 'dart:convert';

import 'package:asms/Constants/ColorConstants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:asms/Screens/fluidBtmNav.dart';
import 'package:asms/Widgets.dart/activePlanCards.dart';
import 'package:asms/Widgets.dart/appBarWidget.dart';
import 'package:flutter/material.dart';

import '../model/activePlansModel.dart';

class ActivePlansPage extends StatefulWidget {
  const ActivePlansPage({super.key});

  @override
  State<ActivePlansPage> createState() => _ActivePlansPageState();
}

class _ActivePlansPageState extends State<ActivePlansPage> {
  final List<ActivePlans> searchedPlans = [];
  String searchString = "";
  DateTime selectedDate = DateTime.now();

  List<ActivePlans> plans = [];
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: appBarWidget(
          context,
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => FluidBottomNav())),
          Icons.arrow_back_ios,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                width: double.infinity,
                color: Colors.grey[200],
                child: const Text(
                  'Active Plans',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Choose Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Text(
                        DateFormat('yyyy-MM-dd')
                            .format(selectedDate)
                            .toString(),
                        style: TextStyle(
                            color: Color(0xff015260),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              txtfield(),
              // searchedPlans.isEmpty ?
              Expanded(
                child: FutureBuilder(
                    future: getActivePlans(
                        formatter.format(selectedDate).toString()),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(ColorConstants.drkGreen1),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final date1 = DateTime.parse(
                                  snapshot.data![index].initialTime.toString());
                              final date2 = DateTime.parse(snapshot
                                  .data![index].trackerstatus
                                  .toString());
                              final difference =
                                  date2.difference(date1).inMinutes;
                              return snapshot.data![index].vehiclename!
                                          .toLowerCase()
                                          .contains(
                                              searchString.toLowerCase()) ||
                                      snapshot.data![index].customername!
                                          .toLowerCase()
                                          .contains(searchString.toLowerCase())
                                  ? ActivePlanCard(
                                      cusname:
                                          snapshot.data![index].customername,
                                      vehName:
                                          snapshot.data![index].vehiclename,
                                      depot: snapshot.data![index].depot,
                                      product: snapshot.data![index].product,
                                      quantity: (double.parse(
                                                  (snapshot.data![index].qty)
                                                      .toString())
                                              .truncate())
                                          .toString(),
                                      time: snapshot.data![index].initialTime,
                                      diff: difference,
                                      id: snapshot.data![index].vehicle,
                                      coPoints: snapshot.data![index].geocor,
                                    )
                                  : Container();
                            });
                      }
                    }),
              )
            ],
          ),
        ));
  }

  txtfield() {
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
                  borderSide:
                      BorderSide(color: Color(ColorConstants.drkGreen1)),
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
          onChanged: (text) {
            setState(() {
              searchString = text;
            });
          },
        ),
      ),
    );
  }

  Future<List<ActivePlans>> getActivePlans(String date) async {
    var client = http.Client();
    plans.clear();
    print(
        'http://151.106.17.246:8080/byco/api/trip.php?accesskey=12345&dater=$date');
    var url = Uri.parse(
        'http://151.106.17.246:8080/byco/api/trip.php?accesskey=12345&dater=$date');
    http.get(url).then((data) {
      return json.decode(data.body);
    }).then((data) {
      for (var json in data) {
        plans.add(ActivePlans.fromJson(json));
      }
    }).catchError((e) {
      print(e);
    });
    var response = await client.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ActivePlans.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        maxTime: DateTime.now(),
        currentTime: DateTime.now(),
        locale: LocaleType.en);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        plans.clear();
      });
    }
  }
}
