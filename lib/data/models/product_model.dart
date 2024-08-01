import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.productName,
      required super.description,
      required super.price,
      required super.imageUrl,
      required super.categoryName});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['productId'],
        productName: json['productName'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['image'],
        categoryName: json['categoryName']);
  }
}
