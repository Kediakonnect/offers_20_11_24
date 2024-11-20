import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CreateTicketEntity extends Equatable {
  final String department;
  final String title;
  final String description;
  final String itemId;

  const CreateTicketEntity(
      {required this.department,
      required this.title,
      required this.description,
      required this.itemId});

  Map<String, dynamic> toJson() {
    return {
      "item_id": itemId,
      "department": department,
      "title": title,
      "description": description
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      "item_id": itemId,
      "department": department,
      "title": title,
      "description": description
    });
  }

  @override
  List<Object?> get props => [itemId, department, title, description];
}
