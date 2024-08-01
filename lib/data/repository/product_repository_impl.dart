import 'package:fpdart/fpdart.dart';
import 'package:task_flutter/core/failure.dart';

import 'package:task_flutter/domain/entities/product.dart';

import '../../domain/respository/product_respository.dart';
import '../datasource/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  ProductRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    try {
      final data = await localDataSource.fetchProduct();
      return right(data);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> filterProductByCategory(
      String query) async {
    try {
      final data = await localDataSource.fetchProduct();
      final filterData = data.where((e) {
        final matchesQuery =
            e.productName.toLowerCase().contains(query.toLowerCase()) ||
                e.categoryName.toLowerCase().contains(query.toLowerCase());

        return matchesQuery;
      }).toList();
      return right(filterData);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
