import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_flutter/core/failure.dart';
import 'package:task_flutter/domain/entities/product.dart';

import 'package:task_flutter/domain/respository/product_respository.dart';
import 'package:task_flutter/domain/usescase/get_all_product.dart';

import '../../mock.dart';
import 'product_usecase_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  provideDummy<Either<Failure, List<Product>>>(right(mockDataProductList));
  final mockProductRepositories = MockProductRepository();
  void setUpSuccessForGetProduct() async {
    when(mockProductRepositories.getAllProduct())
        .thenAnswer((realInvocation) async {
      return right(mockDataProductList);
    });
  }

  void setUpFailureForGetMeMes() async {
    when(mockProductRepositories.getAllProduct())
        .thenAnswer((realInvocation) async => left(mockFailure));
  }

  group('Test for product usecase', () {
    test(
      'while calling getProduct useCases we should get List of Product objects',
      () async {
        setUpSuccessForGetProduct();
        GetAllProducts getAllProducts =
            GetAllProducts(repository: mockProductRepositories);

        final result = await getAllProducts.call();

        expect(result.fold((l) => l, (r) => r), mockDataProductList);
      },
    );

    test(
      'while calling getMemes useCases we should get Failure',
      () async {
        setUpFailureForGetMeMes();
        GetAllProducts getAllProducts =
            GetAllProducts(repository: mockProductRepositories);

        final result = await getAllProducts.call();

        expect(result.fold((l) => l, (r) => r), mockFailure);
      },
    );
  });
}
