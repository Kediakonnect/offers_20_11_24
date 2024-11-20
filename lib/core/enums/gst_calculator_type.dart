enum GSTCalculatorType {
  diamondsToCoins,
  purchaseCoins,
}

extension GSTCalculatorTypeExtension on GSTCalculatorType {
  bool get isDiamondsToCoins => this == GSTCalculatorType.diamondsToCoins;

  String get title {
    switch (this) {
      case GSTCalculatorType.diamondsToCoins:
        return 'Diamonds To Coins';
      case GSTCalculatorType.purchaseCoins:
        return 'Purchase Coins';
    }
  }

  String get calculatorText {
    switch (this) {
      case GSTCalculatorType.diamondsToCoins:
        return 'amount to be converted into coins';
      case GSTCalculatorType.purchaseCoins:
        return 'Coins cost';
    }
  }

  String get getBtnText {
    switch (this) {
      case GSTCalculatorType.diamondsToCoins:
        return 'Convert';
      case GSTCalculatorType.purchaseCoins:
        return 'Make Payment';
    }
  }

  String get getHintText {
    switch (this) {
      case GSTCalculatorType.diamondsToCoins:
        return 'Bonus Diamonds to convent';
      case GSTCalculatorType.purchaseCoins:
        return 'Number of Coins to purchase';
    }
  }
}
