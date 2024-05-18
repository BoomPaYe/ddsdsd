// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String id;
  String date;
  String name;
  String price;
  String imageUrl;
  List<String> features;
  String readmore;

  ProductModel({
    required this.id,
    required this.date,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.features,
    required this.readmore,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        date: json["date"],
        name: json["name"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        features: List<String>.from(json["features"].map((x) => x)),
        readmore: json["readmore"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "name": name,
        "price": price,
        "imageUrl": imageUrl,
        "features": List<dynamic>.from(features.map((x) => x)),
        "readmore": readmore,
      };
}
