// To parse this JSON data, do
//
//     final inventoryModel = inventoryModelFromJson(jsonString);

import 'dart:convert';

List<CatExpenseModel> AssetTypeListSMModelFromJson(String str) =>
    List<CatExpenseModel>.from(
        json.decode(str).map((x) => CatExpenseModel.fromJson(x)));

String AssetTypeListSMModelToJson(List<CatExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatExpenseModel {
  CatExpenseModel({
    this.id,
    this.name,
    // this.description,
  });

  int? id;
  String? name;
  // String? description;

  factory CatExpenseModel.fromJson(Map<String, dynamic> json) =>
      CatExpenseModel(
        id: json["id"],
        name: json["asset_type"],
        // description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "description": description,
      };
}
