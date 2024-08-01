import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_flutter/presentation/bloc/bloc.dart';
import 'package:task_flutter/presentation/bloc/event.dart';

import 'package:task_flutter/presentation/page/product_page.dart';

import 'data/datasource/product_local_data_source.dart';
import 'data/repository/product_repository_impl.dart';

import 'domain/usescase/filter_product.dart';
import 'domain/usescase/get_all_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = ProductLocalDataSourceImpl();
  final repository = ProductRepositoryImpl(localDataSource: localDataSource);
  final getProductsUseCase = GetAllProducts(repository: repository);
  final getSearchUseCase = FilterProduct(repository: repository);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(
          getProducts: getProductsUseCase, searchProducts: getSearchUseCase)
        ..add(FetchProductsEvent()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          bodySmall: TextStyle(fontSize: 14),
        ),
      ),
      home: const ProductPage(),
    );
  }
}
