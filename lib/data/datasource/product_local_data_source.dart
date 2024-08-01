import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:task_flutter/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> fetchProduct();
  Future<List<ProductModel>> filterProduct(String param);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> fetchProduct() async {
    final response = await rootBundle.loadString('assets/products.json');
    final data = json.decode(response) as List;
    await Future.delayed(const Duration(seconds: 2));
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<ProductModel>> filterProduct(String param) async {
    final products = await fetchProduct();
    // Match category name (case-insensitive and partial match)
    return products
        .where((product) =>
            product.categoryName.toLowerCase().contains(param.toLowerCase()))
        .toList();
  }
}
