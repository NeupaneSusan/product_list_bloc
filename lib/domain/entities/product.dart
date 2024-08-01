class Product {
  final String id;
  final String productName;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryName;

  Product(
      {required this.id,
      required this.productName,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.categoryName});
}
