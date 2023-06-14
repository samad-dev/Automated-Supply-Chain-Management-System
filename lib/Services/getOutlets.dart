import 'dart:convert';

import 'package:asms/model/outletModel.dart';
import 'package:http/http.dart' as http;

Future<List<PetrolPump>> getData() async {
  var client = http.Client();
  var url = Uri.parse(
      'http://151.106.17.246:8080/byco/api/geolist.php?accesskey=12345');
  var response = await client.get(url);
  if (response.statusCode == 200) {
    // var json = response.body;
    List jsonResponse = json.decode(response.body);
    // print("Saad" + jsonResponse.length.toString());
    // for (int i=0;i<=jsonResponse.l)

    return jsonResponse.map((data) => new PetrolPump.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}


