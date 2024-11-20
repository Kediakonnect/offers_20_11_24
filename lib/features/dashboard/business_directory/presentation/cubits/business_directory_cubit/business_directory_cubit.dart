import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/core/utils/download_image.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart'
    as businessDirectory;
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/add_business_to_favourite_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_offer_list_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_all_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/rate_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/share_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/add_business_to_favorite_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/create_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/delete_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_all_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_my_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/rate_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/share_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/update_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/verify_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/utils/business_offer_list_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'business_directory_state.dart';

class BusinessDirectoryCubit extends Cubit<BusinessDirectoryState> {
  final CreateBusinessUseCase _createBusinessUseCase;
  final GetAllBusinessUseCase _getAllBusinessUseCase;
  final UpdateBusinessUseCase _updateBusinessUseCase;
  final GetMyBusinessUseCase _getMyBusinessUseCase;
  final VerifyBusinessUseCase _verifyBusinessUseCase;
  final RateBusinessUseCase _rateBusinessUseCase;
  final ShareBusinessUseCase _shareBusinessUseCase;
  final AddBusinessToFavoriteUseCase _addBusinessToFavoriteUseCase;
  final DeleteMyBusinessUseCase _deleteMyBusinessUseCase;
  GetAllBusinessEntity? _lastFetchedEntity;

  String? stateName, districtName, talukaName;
  BusinessDirectoryCubit({
    required GetAllBusinessUseCase getAllBusinessUseCase,
    required CreateBusinessUseCase createBusinessUseCase,
    required UpdateBusinessUseCase updateBusinessUseCase,
    required GetMyBusinessUseCase getMyBusinessUseCase,
    required VerifyBusinessUseCase verifyBusinessUseCase,
    required RateBusinessUseCase rateBusinessUseCase,
    required ShareBusinessUseCase shareBusinessUseCase,
    required AddBusinessToFavoriteUseCase addBusinessToFavoriteUseCase,
    required DeleteMyBusinessUseCase deleteMyBusinessUseCase,
  })  : _createBusinessUseCase = createBusinessUseCase,
        _getAllBusinessUseCase = getAllBusinessUseCase,
        _updateBusinessUseCase = updateBusinessUseCase,
        _getMyBusinessUseCase = getMyBusinessUseCase,
        _verifyBusinessUseCase = verifyBusinessUseCase,
        _rateBusinessUseCase = rateBusinessUseCase,
        _shareBusinessUseCase = shareBusinessUseCase,
        _addBusinessToFavoriteUseCase = addBusinessToFavoriteUseCase,
        _deleteMyBusinessUseCase = deleteMyBusinessUseCase,
        super(BusinessDirectoryInitial());

  BusinessEntity businessEntity = BusinessEntity.toEmpty();

  BusinessFormType formType = BusinessFormType.add;

  void setFormType(BusinessFormType type) {
    formType = type;
  }

  Future<void> refetch() async {
    await getAllBusiness(_lastFetchedEntity!, isOptimisticUpdate: true);
  }

  Future<void> addBusiness() async {
    emit(BusinessDirectoryLoading());
    late Either<Failure, ApiBaseResponse> result;
    if (formType.isAdd) {
      result = await _createBusinessUseCase.call(businessEntity);
    } else {
      result = await _updateBusinessUseCase
          .call(businessEntity.copyWith(method: 'patch'));
    }
    result.fold(
      (failure) {
        emit(BusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..'));
      },
      (response) {
        emit(BusinessDirectorySuccess(message: response.message));
      },
    );
  }

  Future<void> getAllBusiness(GetAllBusinessEntity entity,
      {bool? isOptimisticUpdate = false}) async {
    if (!isOptimisticUpdate!) {
      emit(GetALlBusinessLoadingState());
    } else {
      emit(OptimisticState());
    }

    _lastFetchedEntity = entity;

    final result = await _getAllBusinessUseCase.call(entity);
    result.fold(
      (failure) {
        debugPrint(failure.toString());
        emit(
          GetAllBusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        BusinessOfferListEntity offerList =
            BusinessOfferListHelper.createOfferEntityList(
                response.data?.businesses ?? [], response.data?.offers ?? []);

        emit(
          GetAllBusinessSuccessState(
            data: offerList,
          ),
        );
      },
    );
  }

  Future<void> setBusinessEntity(BusinessEntity businessEntity) async {
    this.businessEntity = businessEntity.copyWith(isNeworkImages: false);

    emit(EditBusinessFormLoadingState());

    if (businessEntity.primaryImage.isNotEmpty) {
      File? primaryImage = await NetworkImageHelper.downloadAndSaveImageTemp(
          businessEntity.primaryImage);
      if (primaryImage != null) {
        businessEntity =
            businessEntity.copyWith(primaryImage: primaryImage.path);
      }
    }
    List<File?> secondaryImages = [];
    if (businessEntity.secondaryImages.isNotEmpty) {
      for (var image in businessEntity.secondaryImages) {
        File? secondaryImage =
            await NetworkImageHelper.downloadAndSaveImageTemp(image);
        if (secondaryImage != null) {
          secondaryImages.add(secondaryImage);
        }
      }
      if (secondaryImages.isNotEmpty) {
        businessEntity = businessEntity.copyWith(
            secondaryImages: secondaryImages.map((e) => e!.path).toList());
      }
    }

    this.businessEntity = businessEntity;

    debugPrint(
      'set business entity ${businessEntity.state} ${businessEntity.district} ${businessEntity.taluka}',
    );
    debugPrint(
      'set business entity ${businessEntity.stateName} ${businessEntity.districtName} ${businessEntity.talukaName}',
    );

    emit(BusinessDirectoryInitial());
  }

  Future<void> getMyBusiness() async {
    emit(BusinessDirectoryLoading());
    final result = await _getMyBusinessUseCase.call(NoParams());
    result.fold(
      (failure) {
        emit(
          BusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          GetMyBusinessSuccessState(
            data: response.data ?? [],
          ),
        );
      },
    );
  }

  Future<void> verifyBusiness(VerifyBusinessEntity entity) async {
    emit(BusinessDirectoryLoading());
    final result = await _verifyBusinessUseCase.call(entity);
    result.fold(
      (failure) {
        emit(
          BusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          const BusinessDirectorySuccess(
            message: "Business verified successfully",
          ),
        );
      },
    );
  }

  Future<void> rateBusiness(RateBusinessEntity entity) async {
    emit(BusinessDirectoryLoading());
    final result = await _rateBusinessUseCase.call(entity);
    result.fold(
      (failure) {
        emit(
          BusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          RateBusinessSuccessState(),
        );
      },
    );
  }

  Future<void> shareBusiness(ShareBusinessEntity entity) async {
    emit(BusinessDirectoryLoading());
    final result = await _shareBusinessUseCase.call(entity);
    result.fold(
      (failure) {
        emit(
          BusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          RateBusinessSuccessState(),
        );
      },
    );
  }

  Future<void> addBusinessToFavorite(
      AddBusinessToFavouriteEntity entity) async {
    emit(AddBusinessToFavoriteInitial());
    final result = await _addBusinessToFavoriteUseCase.call(entity);
    result.fold(
      (failure) {
        emit(
          BusinessDirectoryFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          AddBusinessToFavoriteSuccessState(),
        );
      },
    );
  }

  Future<void> deleteBusiness(String businessId) async {
    emit(BusinessDirectoryLoading());

    final result = await _deleteMyBusinessUseCase.call(businessId);

    result.fold(
      (failure) {
        emit(
          BusinessDirectoryFailure(
            message: failure.message ?? 'Failed to delete the business.',
          ),
        );
      },
      (response) {
        emit(
          BusinessDirectorySuccess(
            message: response.message ?? 'Business deleted successfully.',
          ),
        );
      },
    );
  }

  void categoryLevel3Changed(List<String> categoryLevel3) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(categoryLevel3: categoryLevel3);
  }

  void nameChanged(String name) {
    emit(BusinessDirectoryInitial());
    debugPrint(name);
    businessEntity = businessEntity.copyWith(name: name);
  }

  void mobileChanged(String mobile) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(mobile: mobile);
  }

  void emailChanged(String email) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(email: email);
  }

  void contactPersonChanged(String contactPerson) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(contactPerson: contactPerson);
  }

  void websiteUrlChanged(String websiteUrl) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(websiteUrl: websiteUrl);
  }

  void whatsappNumberChanged(String whatsappNumber) {
    if (whatsappNumber.isNotEmpty) {
      emit(BusinessDirectoryInitial());
      businessEntity = businessEntity.copyWith(whatsappNumber: whatsappNumber);
    }
  }

  void stateChanged(StateModel state) {
    if (state.name.isNotEmpty) {
      emit(BusinessDirectoryInitial());
      stateName = state.name;
      businessEntity = businessEntity.copyWith(state: state.id);
    }
  }

  void metroCityChanged(String metroCity) {
    if (metroCity.isNotEmpty) {
      emit(BusinessDirectoryInitial());
      businessEntity = businessEntity.copyWith(metroCity: metroCity);
    }
  }

  void districtChanged(businessDirectory.District district) {
    if (district.name.isNotEmpty) {
      emit(BusinessDirectoryInitial());
      districtName = district.name;
      businessEntity = businessEntity.copyWith(district: district.id);
    }
  }

  void talukaChanged(Taluka taluka) {
    emit(BusinessDirectoryInitial());
    talukaName = taluka.name;
    businessEntity = businessEntity.copyWith(taluka: taluka.id);
  }

  void registeredAddressChanged(String registeredAddress) {
    emit(BusinessDirectoryInitial());
    businessEntity =
        businessEntity.copyWith(registeredAddress: registeredAddress);
  }

  void pinCodeChanged(String pinCode) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(pinCode: pinCode);
  }

  void googleMapLinkChanged(String googleMapLink) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(googleMapLink: googleMapLink);
  }

  void openingTimeChanged(String openingTime) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(openingTime: openingTime);
  }

  void closingTimeChanged(String closingTime) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(closingTime: closingTime);
  }

  void categoryLevel1Changed(String categoryLevel1, String name) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(
        categoryLevel1: categoryLevel1,
        categoryName: name,
        categoryLevel2: '',
        categoryLevel3: []);
  }

  void categoryLevel2Changed(String categoryLevel2) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity
        .copyWith(categoryLevel2: categoryLevel2, categoryLevel3: []);
  }

  void secondaryImagesChanged(List<File> secondaryImages) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(
        secondaryImages: secondaryImages.map((e) => e.path).toList());
  }

  void primaryImageChanged(File primaryImage) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(primaryImage: primaryImage.path);
  }

  void logoImageChanged(File logoImage) {
    emit(BusinessDirectoryInitial());
    businessEntity = businessEntity.copyWith(logoImage: logoImage.path);
  }
}
