import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

// class ProductService {
//   static Future readProducts({
//     required void Function(List<ProductModel>?) onResult,
//     required void Function(String?) onReject,
//   }) async {
//     try {
//       http.Response res = await http.get(
//         Uri.parse("http://localhost:3000/products/"),
//       );
//       onResult(await compute(_convertData, res.body));
//       onReject(null);
//     } catch (e) {
//       onReject("Error: ${e.toString()}");
//     }
//   }

//   static List<ProductModel> _convertData(String data) {
//     List<ProductModel> list = productModelFromJson(data);
//     return list;
//   }
// }

class ProductService {
  static const String baseUrl = "http://10.0.2.2:3000";
  static List<ProductModel> _convertData(String data) {
    List<ProductModel> list = productModelFromJson(data);
    return list;
  }

  static Future readProducts({
    required void Function(List<ProductModel>?) onResult,
    required void Function(String?) onReject,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/products");
      http.Response res = await http.get(url);
      onResult(await compute(_convertData, res.body));
      onReject(null);
    } catch (e) {
      onReject("Error: ${e.toString()}");
    }
  }
}
