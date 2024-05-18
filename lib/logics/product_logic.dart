import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductLogic extends ChangeNotifier {
  List<ProductModel>? _productList;

  List<ProductModel>? get prodctList => _productList;

  bool _loading = false;

  bool get loading => _loading;

  String? _error;

  String? get error => _error;

  void setLoading() {
    _loading = true;
    notifyListeners();
  }

  ProductModel? getProduct(int id) {
    return _productList?.singleWhere((element) => element.id == id);
  }

  Future readProduct() async {
    await ProductService.readProducts(
      onResult: (result) => _productList = result,
      onReject: (e) => _error = e,
    );
    _loading = false;
    notifyListeners();
  }
}
