import 'package:fpdart/fpdart.dart';
import 'package:task_flutter/core/failure.dart';

import 'package:task_flutter/domain/respository/product_respository.dart';

import '../entities/product.dart';

class GetAllProducts {
  final ProductRepository repository;
  GetAllProducts({required this.repository});
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProduct();
  }
}
