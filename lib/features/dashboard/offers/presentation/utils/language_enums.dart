enum LanguageEnums {
  english,
  hindi,
  gujarati,
  kannada,
  malayalam,
  marathi,
  punjabi,
  tamil,
  telugu,
  urdu,
}

extension LanguageEnumsExt2 on String {
  LanguageEnums get languageEnums {
    switch (this) {
      case 'en':
        return LanguageEnums.english;
      case 'hi':
        return LanguageEnums.hindi;
      case 'gu':
        return LanguageEnums.gujarati;
      case 'kn':
        return LanguageEnums.kannada;
      case 'ml':
        return LanguageEnums.malayalam;
      case 'mr':
        return LanguageEnums.marathi;
      case 'pa':
        return LanguageEnums.punjabi;
      case 'ta':
        return LanguageEnums.tamil;
      case 'te':
        return LanguageEnums.telugu;
      case 'ur':
        return LanguageEnums.urdu;
      default:
        return LanguageEnums.english;
    }
  }
}

extension LanguageEnumsExt on LanguageEnums {
  String get label {
    switch (this) {
      case LanguageEnums.english:
        return 'English';
      case LanguageEnums.hindi:
        return 'Hindi';
      case LanguageEnums.gujarati:
        return 'Gujarati';
      case LanguageEnums.kannada:
        return 'Kannada';
      case LanguageEnums.malayalam:
        return 'Malayalam';
      case LanguageEnums.marathi:
        return 'Marathi';
      case LanguageEnums.punjabi:
        return 'Punjabi';
      case LanguageEnums.tamil:
        return 'Tamil';
      case LanguageEnums.telugu:
        return 'Telugu';
      case LanguageEnums.urdu:
        return 'Urdu';
    }
  }

  String get value {
    switch (this) {
      case LanguageEnums.english:
        return 'en';
      case LanguageEnums.hindi:
        return 'hi';
      case LanguageEnums.gujarati:
        return 'gu';
      case LanguageEnums.kannada:
        return 'kn';
      case LanguageEnums.malayalam:
        return 'ml';
      case LanguageEnums.marathi:
        return 'mr';
      case LanguageEnums.punjabi:
        return 'pa';
      case LanguageEnums.tamil:
        return 'ta';
      case LanguageEnums.telugu:
        return 'te';
      case LanguageEnums.urdu:
        return 'ur';
    }
  }
}
