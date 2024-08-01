import 'package:fpdart/fpdart.dart';
import 'package:task_flutter/core/failure.dart';

import '../entities/product.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, List<Product>>> filterProductByCategory(String query);
}
