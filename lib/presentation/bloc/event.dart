abstract class ProductEvent {
  const ProductEvent();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductEvent;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class FetchProductsEvent extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;

  SearchProductsEvent(this.query);
}
