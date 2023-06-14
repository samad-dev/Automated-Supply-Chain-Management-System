// To parse this JSON data, do
//
//     final petrolPump = petrolPumpFromJson(jsonString);

import 'dart:convert';

List<PetrolPump> petrolPumpFromJson(String str) =>
    List<PetrolPump>.from(json.decode(str).map((x) => PetrolPump.fromJson(x)));

String petrolPumpToJson(List<PetrolPump> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetrolPump {
  PetrolPump({
    required this.id,
    required this.consigneeName,
    required this.coordinates,
  });

  String id;
  String consigneeName;
  String coordinates;

  factory PetrolPump.fromJson(Map<String, dynamic> json) => PetrolPump(
        id: json["id"],
        consigneeName: json["consignee_name"],
        coordinates: json["Coordinates"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "consignee_name": consigneeName,
        "Coordinates": coordinates,
      };
}
