import 'package:fpdart/fpdart.dart';
import 'package:task_flutter/core/failure.dart';

import 'package:task_flutter/domain/entities/product.dart';

import '../respository/product_respository.dart';

class FilterProduct {
  final ProductRepository repository;
  FilterProduct({required this.repository});
  Future<Either<Failure, List<Product>>> call(String params) async {
    return await repository.filterProductByCategory(params);
  }
}
