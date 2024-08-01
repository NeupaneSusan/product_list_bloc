import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usescase/filter_product.dart';
import '../../domain/usescase/get_all_product.dart';
import 'event.dart';
import 'states.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getProducts;
  final FilterProduct searchProducts;

  ProductBloc({required this.searchProducts, required this.getProducts})
      : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProducts();
      products.fold((e) {
        return emit(
          ProductError(message: e.message),
        );
      }, (s) => emit(ProductLoaded(products: s)));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onSearchProducts(
      SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await searchProducts(event.query);
      products.fold(
        (e) => {
          emit(
            ProductError(message: e.message),
          ),
        },
        (s) => {emit(ProductLoaded(products: s))},
      );
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
