class RegisterFormValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name must contain only letters and spaces';
    }
    return null;
  }

  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of Birth is required';
    } else if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
      return 'Enter a valid date in DD-MM-YYYY format';
    }

    // DateTime? parsedDate;
    // try {
    //   parsedDate = DateFormat('dd-MM-yyyy').parseStrict(value);
    // } catch (e) {
    //   return 'Enter a valid date in DD-MM-YYYY format';
    // }

    // final today = DateTime.now();
    // final age = today.year - parsedDate.year;
    // final isBeforeBirthday = (today.month < parsedDate.month) ||
    //     (today.month == parsedDate.month && today.day < parsedDate.day);

    // if (age < 18 || (age == 18 && isBeforeBirthday)) {
    //   return 'You must be at least 18 years old';
    // }

    return null;
  }

  static String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN code is required';
    } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Enter a valid 6-digit PIN code';
    }
    return null;
  }
}
