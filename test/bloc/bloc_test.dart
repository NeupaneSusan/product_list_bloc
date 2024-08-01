import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_flutter/core/failure.dart';
import 'package:task_flutter/domain/entities/product.dart';
import 'package:task_flutter/domain/usescase/filter_product.dart';
import 'package:task_flutter/domain/usescase/get_all_product.dart';
import 'package:task_flutter/presentation/bloc/bloc.dart';
import 'package:task_flutter/presentation/bloc/event.dart';

import 'package:task_flutter/presentation/bloc/states.dart';

import '../mock.dart';
import 'bloc_test.mocks.dart';

@GenerateMocks([GetAllProducts, FilterProduct])
void main() {
  final mockGetAllProducts = MockGetAllProducts();
  final mockGetFilterProduct = MockFilterProduct();

  void setupSuccessForProduct() {
    when(mockGetAllProducts.call())
        .thenAnswer((realInvocation) async => Right(mockDataProductList));
  }

  void setupErrorProduct() {
    when(mockGetAllProducts.call())
        .thenAnswer((realInvocation) async => Left(mockFailure));
  }

  provideDummy<Either<Failure, List<Product>>>(Right(mockDataProductList));

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading, ProductLoaded] when FetchProductsEvent is added',
    build: () {
      setupSuccessForProduct();
      return ProductBloc(
        searchProducts: mockGetFilterProduct,
        getProducts: mockGetAllProducts,
      );
    },
    act: (bloc) {
      return bloc.add(FetchProductsEvent());
    },
    expect: () => [
      ProductLoading(),
      ProductLoaded(products: mockDataProductList),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading, ProductError] when FetchProductsEvent is added',
    build: () {
      setupErrorProduct();
      return ProductBloc(
        searchProducts: mockGetFilterProduct,
        getProducts: mockGetAllProducts,
      );
    },
    act: (bloc) {
      return bloc.add(FetchProductsEvent());
    },
    expect: () =>
        [ProductLoading(), ProductError(message: mockFailure.message)],
  );
}
