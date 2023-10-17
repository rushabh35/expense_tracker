// To parse this JSON data, do
//
//     final inventoryModel = inventoryModelFromJson(jsonString);

import 'dart:convert';

List<CatIncomeModel> AssetTypeListSMModelFromJson(String str) =>
    List<CatIncomeModel>.from(
        json.decode(str).map((x) => CatIncomeModel.fromJson(x)));

String AssetTypeListSMModelToJson(List<CatIncomeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatIncomeModel {
  CatIncomeModel({
    this.id,
    this.name,
    // this.description,
  });

  int? id;
  String? name;
  // String? description;

  factory CatIncomeModel.fromJson(Map<String, dynamic> json) =>
      CatIncomeModel(
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
