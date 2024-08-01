import 'package:task_flutter/core/failure.dart';
import 'package:task_flutter/domain/entities/product.dart';

final mockDataProductList = [
  Product(
      id: '1',
      productName: 'productNam',
      description: 'description',
      price: 200,
      imageUrl: 'imageUrl',
      categoryName: 'categoryName')
];

final mockFailure = Failure('Server Failure');
