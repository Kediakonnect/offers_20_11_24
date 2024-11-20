enum BusinessFormType {
  add,
  edit,
}

extension BusinessFormTypeExtension on BusinessFormType {
  bool get isAdd => this == BusinessFormType.add;
  String get appBarTitle {
    switch (this) {
      case BusinessFormType.add:
        return 'Add new business'.toUpperCase();
      case BusinessFormType.edit:
        return 'Edit business'.toUpperCase();
    }
  }
}
