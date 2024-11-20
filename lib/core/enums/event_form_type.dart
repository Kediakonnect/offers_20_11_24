enum EventFormType { create, edit }

extension EventFormTypeExtension on EventFormType {
  String get title {
    switch (this) {
      case EventFormType.create:
        return 'Add New Event'.toUpperCase();
      case EventFormType.edit:
        return 'Edit Event'.toUpperCase();
    }
  }
}
