enum OfferType {
  entry,
  exit,
  b2b,
  notification,
  screen,
}

extension OfferTypeExtension2 on String {
  OfferType? get offerType {
    switch (this) {
      case 'entry':
        return OfferType.entry;
      case 'exit':
        return OfferType.exit;
      case 'b2b':
        return OfferType.b2b;
      case 'banner':
        return OfferType.notification;
      case 'screen':
        return OfferType.screen;
      default:
        return null;
    }
  }
}

extension OfferTypeExtension on OfferType {
  String get label {
    switch (this) {
      case OfferType.entry:
        return 'Entry';
      case OfferType.exit:
        return 'Exit';
      case OfferType.b2b:
        return 'B2B';
      case OfferType.notification:
        return 'Banner';
      case OfferType.screen:
        return 'Regular';
    }
  }

  String get value {
    switch (this) {
      case OfferType.entry:
        return 'entry';
      case OfferType.exit:
        return 'exit';
      case OfferType.b2b:
        return 'b2b';
      case OfferType.notification:
        return 'banner';
      case OfferType.screen:
        return "screen";
    }
  }
}
