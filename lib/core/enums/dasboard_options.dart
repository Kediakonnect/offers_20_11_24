import 'package:divyam_flutter/core/constants/image_constants.dart';

enum DashBoardOptions {
  doctors,
  travel,
  beauty,
  education,
  consultants,
  rentAndHire,
  weddingRequisites,
  jobs,
  repairsAndServices,
  pgAndHostel,
  loans,
  realEstate,
  homeServices,
  dailyNeeds,
  food,
  more,
}

extension DashBoardOptionsExtension on DashBoardOptions {
  String get title {
    switch (this) {
      case DashBoardOptions.doctors:
        return 'Doctors';
      case DashBoardOptions.travel:
        return 'Travel';
      case DashBoardOptions.beauty:
        return 'Beauty';
      case DashBoardOptions.education:
        return 'Education';
      case DashBoardOptions.consultants:
        return 'Consultants';
      case DashBoardOptions.rentAndHire:
        return 'Rent & Hire';
      case DashBoardOptions.weddingRequisites:
        return 'Weddings Requisites';
      case DashBoardOptions.jobs:
        return 'Jobs';
      case DashBoardOptions.repairsAndServices:
        return 'Repairs & Services';
      case DashBoardOptions.pgAndHostel:
        return 'PG/Hostel';
      case DashBoardOptions.loans:
        return 'Loans';
      case DashBoardOptions.realEstate:
        return 'Real Estate';
      case DashBoardOptions.homeServices:
        return 'Home Services';
      case DashBoardOptions.food:
        return 'Food';
      case DashBoardOptions.dailyNeeds:
        return 'Daily Needs';
      case DashBoardOptions.more:
        return 'More';
    }
  }

  String get assetName {
    switch (this) {
      case DashBoardOptions.doctors:
        return AppIcons.doctor;
      case DashBoardOptions.travel:
        return AppIcons.travel;
      case DashBoardOptions.beauty:
        return AppIcons.beauty;
      case DashBoardOptions.education:
        return AppIcons.education;
      case DashBoardOptions.consultants:
        return AppIcons.consultancy;
      case DashBoardOptions.rentAndHire:
        return AppIcons.rentAndHire;
      case DashBoardOptions.weddingRequisites:
        return AppIcons.favourite;
      case DashBoardOptions.loans:
        return AppIcons.loans;
      case DashBoardOptions.realEstate:
        return AppIcons.realEstate;
      case DashBoardOptions.homeServices:
        return AppIcons.homeServices;
      case DashBoardOptions.food:
        return AppIcons.food;
      case DashBoardOptions.more:
        return AppIcons.more;
      case DashBoardOptions.jobs:
        return AppIcons.jobs;
      case DashBoardOptions.repairsAndServices:
        return AppIcons.repairsAndServices;
      case DashBoardOptions.pgAndHostel:
        return AppIcons.pgAndHostel;
      case DashBoardOptions.dailyNeeds:
        return AppIcons.dailyNeeds;
    }
  }
}
