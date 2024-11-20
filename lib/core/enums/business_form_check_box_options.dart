enum BusinessFormCheckBoxOptions {
  banking,
  investment,
  insurance,
  financial,
  shareTrading
}

extension BusinessFormCheckBoxOptionsExtension on BusinessFormCheckBoxOptions {
  String get name {
    switch (this) {
      case BusinessFormCheckBoxOptions.banking:
        return 'Banking';
      case BusinessFormCheckBoxOptions.investment:
        return 'Investment';
      case BusinessFormCheckBoxOptions.insurance:
        return 'Insurance';
      case BusinessFormCheckBoxOptions.financial:
        return 'Financial planning and advisory';
      case BusinessFormCheckBoxOptions.shareTrading:
        return 'Share Trading';
    }
  }
}
