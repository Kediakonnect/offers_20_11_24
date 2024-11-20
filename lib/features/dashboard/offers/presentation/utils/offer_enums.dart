enum ProductType { buy, sell }

extension ProductTypeExtension on ProductType {
  String get label {
    switch (this) {
      case ProductType.buy:
        return 'Buy';
      case ProductType.sell:
        return 'Sell';
    }
  }

  String get value {
    switch (this) {
      case ProductType.buy:
        return 'buy';
      case ProductType.sell:
        return 'sell';
    }
  }
}

extension ProductTypeExtension2 on String {
  ProductType? get productType {
    switch (this) {
      case 'buy':
        return ProductType.buy;
      case 'sell':
        return ProductType.sell;
      default:
        return null;
    }
  }
}
