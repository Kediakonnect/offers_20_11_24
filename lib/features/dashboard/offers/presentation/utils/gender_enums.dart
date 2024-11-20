enum Gendertypes { male, female, all }

extension GendertypesExt2 on String {
  Gendertypes? get genderType {
    switch (this) {
      case 'male':
        return Gendertypes.male;
      case 'female':
        return Gendertypes.female;
      default:
        return null;
    }
  }
}

extension GendertypesExt on Gendertypes {
  String get label {
    switch (this) {
      case Gendertypes.male:
        return 'Male';
      case Gendertypes.female:
        return 'Female';
      case Gendertypes.all:
        return "All";
    }
  }

  String get value {
    switch (this) {
      case Gendertypes.male:
        return 'male';
      case Gendertypes.female:
        return 'female';
      case Gendertypes.all:
        return "all";
    }
  }
}
