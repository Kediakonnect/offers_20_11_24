enum AddAnnoucementFormType { create, edit }

extension AddAnnoucementFormTypeExtension on AddAnnoucementFormType {
  bool get isEdit => this == AddAnnoucementFormType.edit;

  String get title => isEdit
      ? 'Edit Annoucement'.toUpperCase()
      : 'Create Annoucement'.toUpperCase();
}
