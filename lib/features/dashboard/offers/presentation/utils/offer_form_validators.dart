class OffersValidators {
  static String? validateBusinessName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Business Name is required';
    }
    return null;
  }

  static String? validateOfferType(String? name) {
    if (name == null || name.isEmpty) {
      return 'Offer Type is required';
    }
    return null;
  }

  static String? validateBuyAndSellOffer(String? name) {
    if (name == null || name.isEmpty) {
      return 'Buy and Sell Offer is required';
    }
    return null;
  }

  static String? validateLanguage(String? name) {
    if (name == null || name.isEmpty) {
      return 'Language is required';
    }
    return null;
  }

  static String? validateOfferTitle(String? name) {
    if (name == null || name.isEmpty) {
      return 'Offer Title is required';
    }
    return null;
  }

  static String? validateOfferDescription(String? name) {
    if (name == null || name.isEmpty) {
      return 'Offer Description is required';
    }
    return null;
  }

  static String? validateFromAge(String? name) {
    if (name == null || name.isEmpty) {
      return 'From Age is required';
    }
    return null;
  }

  static String? validateToAge(String? name) {
    if (name == null || name.isEmpty) {
      return 'To Age is required';
    }
    return null;
  }

  static String? validateSex(String? name) {
    if (name == null || name.isEmpty) {
      return 'Gender is required';
    }
    return null;
  }

  static String? validateProductName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Product Name is required';
    }
    return null;
  }

  static String? validateOriginalPrice(String? name) {
    if (name == null || name.isEmpty) {
      return 'Original Price is required';
    }

    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(name)) {
      return 'Original Price must be a valid number (e.g., 123 or 123.45)';
    }

    return null;
  }

  static String? validateOfferPrice(String? name) {
    if (name == null || name.isEmpty) {
      return 'Offer Price is required';
    }

    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(name)) {
      return 'Offer Price must be a valid number (e.g., 123 or 123.45)';
    }

    return null;
  }
}
