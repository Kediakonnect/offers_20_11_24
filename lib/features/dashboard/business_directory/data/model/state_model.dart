import 'package:divyam_flutter/ui/moleclues/checkbox_treeview.dart';
import 'package:hive/hive.dart';

part 'state_model.g.dart';

class OfferRateModel {
  final String id;
  final String stateId;
  final String districtId;
  final String talukaId;
  final int freeImpressions;
  final double bannerRate;
  final double entryRate;
  final double regularRate;
  final double exitRate;
  final double b2bRate;

  OfferRateModel({
    required this.id,
    required this.stateId,
    required this.districtId,
    required this.talukaId,
    required this.freeImpressions,
    required this.bannerRate,
    required this.entryRate,
    required this.regularRate,
    required this.exitRate,
    required this.b2bRate,
  });

  // Factory constructor to create a model from JSON
  factory OfferRateModel.fromJson(Map<String, dynamic> json) {
    return OfferRateModel(
      id: json['id'] as String,
      stateId: json['state_id'] as String,
      districtId: json['district_id'] as String,
      talukaId: json['taluka_id'] as String,
      freeImpressions: int.parse(json['free_impressions']),
      bannerRate: double.parse(json['bannerRate']),
      entryRate: double.parse(json['entryRate']),
      regularRate: double.parse(json['regularRate']),
      exitRate: double.parse(json['exitRate']),
      b2bRate: double.parse(json['b2bRate']),
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_id': stateId,
      'district_id': districtId,
      'taluka_id': talukaId,
      'free_impressions': freeImpressions.toString(),
      'bannerRate': bannerRate.toString(),
      'entryRate': entryRate.toString(),
      'regularRate': regularRate.toString(),
      'exitRate': exitRate.toString(),
      'b2bRate': b2bRate.toString(),
    };
  }
}

@HiveType(typeId: 0)
class Taluka extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int areaCode;

  @HiveField(3)
  final int? userCount;

  @HiveField(4)
  final OfferRateModel? offerRate;

  Taluka({
    required this.id,
    required this.name,
    required this.areaCode,
    required this.userCount,
    required this.offerRate,
  });

  factory Taluka.fromJson(Map<String, dynamic> json) {
    return Taluka(
      id: json['id'] as String,
      name: json['name'] as String,
      areaCode: json['area_code'] as int,
      userCount: json['usercount'] == null ? 0 : json['usercount'] as int,
      offerRate: json['offer_rate'] != null
          ? OfferRateModel.fromJson(json['offer_rate'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Taluka) return false;
    return name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}

@HiveType(typeId: 1)
class District extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<Taluka> talukas;

  @HiveField(3)
  final String? isMetro;

  District({
    required this.id,
    required this.name,
    required this.talukas,
    this.isMetro,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as String,
      name: json['name'] as String,
      isMetro: json['is_metro'] as String?,
      talukas: (json['talukas'] as List<dynamic>)
          .map((talukaJson) =>
              Taluka.fromJson(talukaJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! District) return false;
    return name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}

@HiveType(typeId: 2)
class StateModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<District> districts;

  StateModel({
    required this.id,
    required this.name,
    required this.districts,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      districts: (json['districts'] as List<dynamic>)
          .map((districtJson) =>
              District.fromJson(districtJson as Map<String, dynamic>))
          .toList(),
    );
  }

  StateModel copyWith({
    String? id,
    String? name,
    List<District>? districts,
  }) {
    return StateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      districts: districts ?? this.districts,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StateModel) return false;
    return name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  map(TreeNode Function(dynamic state) param0) {}
}

@HiveType(typeId: 3)
class StateModelResponse {
  @HiveField(0)
  final List<StateModel> states;
  StateModelResponse({required this.states});

  factory StateModelResponse.fromJson(Map<String, dynamic> json) {
    return StateModelResponse(
      states: (json['states'] as List<dynamic>)
          .map((stateJson) =>
              StateModel.fromJson(stateJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
