import 'dart:io';

class BusinessFormValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  static String? validateLogoImage(File? logoImage) {
    if (logoImage == null || !logoImage.existsSync()) {
      return 'Logo image is required';
    }
    return null;
  }

  static String? validateMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) {
      return 'Mobile number is required';
    }
    final RegExp mobileRegExp = RegExp(r'^[0-9]{10}$');
    if (!mobileRegExp.hasMatch(mobile)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,4})+$');
    if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateContactPerson(String? contactPerson) {
    if (contactPerson == null || contactPerson.isEmpty) {
      return 'Contact person is required';
    }
    return null;
  }

  static String? validateWebsiteUrl(String? websiteUrl) {
    if (websiteUrl == null || websiteUrl.isEmpty) {
      return 'Website URL is required';
    }
    final RegExp urlRegExp = RegExp(
        r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$');
    if (!urlRegExp.hasMatch(websiteUrl)) {
      return 'Enter a valid website URL';
    }
    return null;
  }

  static String? validateWhatsappNumber(String? whatsappNumber) {
    if (whatsappNumber != null && whatsappNumber.isEmpty) {
      final RegExp whatsappRegExp = RegExp(r'^[0-9]{10}$');
      if (!whatsappRegExp.hasMatch(whatsappNumber)) {
        return 'Enter a valid 10-digit WhatsApp number';
      }
    }
    return null;
  }

  static String? validateState(String? state) {
    if (state == null || state.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  static String? validateMetroCity(String? metroCity) {
    if (metroCity == null || metroCity.isEmpty) {
      return 'Metro city is required';
    }
    return null;
  }

  static String? validateDistrict(String? district) {
    if (district == null || district.isEmpty) {
      return 'District is required';
    }
    return null;
  }

  static String? validateTaluka(String? taluka) {
    if (taluka == null || taluka.isEmpty) {
      return 'Taluka is required';
    }
    return null;
  }

  static String? validateRegisteredAddress(String? registeredAddress) {
    if (registeredAddress == null || registeredAddress.isEmpty) {
      return 'Registered address is required';
    }
    return null;
  }

  static String? validatePinCode(String? pinCode) {
    if (pinCode == null || pinCode.isEmpty) {
      return 'Pin code is required';
    }
    final RegExp pinCodeRegExp = RegExp(r'^[0-9]{6}$');
    if (!pinCodeRegExp.hasMatch(pinCode)) {
      return 'Enter a valid 6-digit pin code';
    }
    return null;
  }

  static String? validateGoogleMapLink(String? googleMapLink) {
    if (googleMapLink == null || googleMapLink.isEmpty) {
      return 'Google map link is required';
    }
    final RegExp urlRegExp = RegExp(
        r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$');
    if (!urlRegExp.hasMatch(googleMapLink)) {
      return 'Enter a valid Google map link';
    }
    return null;
  }

  static String? validateOpeningTime(String? openingTime) {
    if (openingTime == null || openingTime.isEmpty) {
      return 'Opening time is required';
    }
    // You might want to validate time format here
    return null;
  }

  static String? validateClosingTime(String? closingTime) {
    if (closingTime == null || closingTime.isEmpty) {
      return 'Closing time is required';
    }
    // You might want to validate time format here
    return null;
  }

  static String? validateCategoryLevel1(String? categoryLevel1) {
    if (categoryLevel1 == null || categoryLevel1.isEmpty) {
      return 'Category level 1 is required';
    }
    return null;
  }

  static String? validateCategoryLevel2(String? categoryLevel2) {
    if (categoryLevel2 == null || categoryLevel2.isEmpty) {
      return 'Category level 2 is required';
    }
    return null;
  }
}
