import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_my_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/wallet_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/add_offer_to_favorite_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_all_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_my_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_offer_by_id_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/view_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/add_offers_to_favorite_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/create_offers_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/delete_offer_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_all_offers_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_my_offers_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_offer_by_id_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_user_wallet_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/view_offer_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_enums.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_type_enum.dart';
import 'package:divyam_flutter/ui/moleclues/checkbox_treeview.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final GetAllOffersUseCase _allOffersUseCase;
  final GetMyBusinessUseCase _getMyBusinessUseCase;
  final CreateOfferUseCase _createOfferUseCase;
  final GetMyOffersUseCase _getMyOffersUseCase;
  final ViewOfferUseCase _viewOfferUseCase;
  final AddOffersToFavouriteUseCase _addOffersToFavouriteUseCase;
  final GetOfferByIdUseCase _getOfferByIdUseCase;
  final GetUserWalletBalanceUseCase _getUserWalletBalanceUseCase;
  final DeleteOfferUseCase _deleteOfferUseCase;

  OffersCubit({
    required GetAllOffersUseCase allOffersUseCase,
    required CreateOfferUseCase createOfferUseCase,
    required GetMyOffersUseCase getMyOffersUseCase,
    required ViewOfferUseCase viewOfferUseCase,
    required AddOffersToFavouriteUseCase addOffersToFavouriteUseCase,
    required GetMyBusinessUseCase getMyBusinessUseCase,
    required GetOfferByIdUseCase getOfferByIdUseCase,
    required GetUserWalletBalanceUseCase getUserWalletBalanceUseCase,
    required DeleteOfferUseCase deleteOfferUseCase, // Inject DeleteOfferUseCase
  })  : _allOffersUseCase = allOffersUseCase,
        _getMyBusinessUseCase = getMyBusinessUseCase,
        _createOfferUseCase = createOfferUseCase,
        _getMyOffersUseCase = getMyOffersUseCase,
        _viewOfferUseCase = viewOfferUseCase,
        _addOffersToFavouriteUseCase = addOffersToFavouriteUseCase,
        _getOfferByIdUseCase = getOfferByIdUseCase,
        _getUserWalletBalanceUseCase = getUserWalletBalanceUseCase,
        _deleteOfferUseCase = deleteOfferUseCase, // Assign DeleteOfferUseCase
        super(OffersInitial());

  CreateOfferEntity entity = CreateOfferEntity.empty();

  OfferModel? selectedOffer;

  List<BusinessModel> myBusinesses = [];

  BusinessModel? selectedBusiness;

  GetAllOffersEntity _getAllOffersEntity = GetAllOffersEntity.toEmpty();

  late List<TreeNode> nodes;
  late List<TreeNode> selectedNodes;

  Future<void> update(OfferModel offer) async {
    emit(UpdateFormLoadingState());
    selectedOffer = offer;
    entity = await offer.toEntity();
    emit(UpdateFormSuccessState());
  }

  Future<void> refetch() async {
    // if (_lastFetchedEntity == null) {
    //   return;
    // }
    await getAllBOffers(isOptimisticUpdate: true);
  }

  void createForm(CreateOfferType type) {
    entity = entity.copyWith(offerFormType: type);
  }

  Future<void> getMyBusiness() async {
    emit(GetMyBusinessLoadingState());
    final result = await _getMyBusinessUseCase.call(NoParams());
    result.fold((l) {
      emit(GetMyBusinessFailure(message: l.message ?? 'Something went wrong!'));
    }, (r) {
      myBusinesses = r.data ?? [];

      debugPrint(myBusinesses.length.toString());
      emit(GetMyBusinessSuccessState(data: myBusinesses));
    });
  }

  Future<void> getMyOffers(GetMyOffersEntity entity) async {
    emit(GetAllOffersLoading());
    final result = await _getMyOffersUseCase.call(entity);
    result.fold(
      (failure) {
        debugPrint(failure.toString());

        emit(
          GetAllOffersFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          GetAllOffersSuccessState(
            data: response.data ?? [],
          ),
        );
      },
    );
  }

  Future<void> createOffer(CreateOfferType type) async {
    entity = entity.copyWith(offerFormType: type);
    emit(CreateOfferLoadingState());
    final result = await _createOfferUseCase.call(entity);
    result.fold((l) {
      emit(CreateOfferFailure(message: l.message ?? 'Something went wrong!'));
    }, (r) {
      emit(const CreateOfferSuccessState());
    });
  }

  Future<void> viewOffer({required ViewOfferEntity entity}) async {
    emit(ViewOfferLoadingState());
    final result = await _viewOfferUseCase.call(entity);
    result.fold((l) {
      emit(ViewOffersFailure(message: l.message ?? 'Something went wrong!'));
    }, (r) {
      emit(const ViewOfferSuccessState());
    });
  }

  Future<void> performSocialAction({required OfferSocialEntity entity}) async {
    emit(AddOffersToFavoriteInitial());
    final result = await _addOffersToFavouriteUseCase.call(entity);
    result.fold((l) {
      emit(ViewOffersFailure(message: l.message ?? 'Something went wrong!'));
    }, (r) {
      emit(AddOffersToFavoriteSuccessState());
    });
  }

  Future<void> getOfferById({required GetOfferByIdEntity entity}) async {
    emit(GetOfferByIdInitial());
    final result = await _getOfferByIdUseCase.call(entity);
    result.fold((l) {
      emit(GetOfferByIdFailure(message: l.message ?? 'Something went wrong!'));
    }, (r) {
      emit(GetOfferByIdSuccessState(data: r.data));
    });
  }

  Future<void> getUserWalletBalance() async {
    emit(GetOfferByIdInitial());
    final result = await _getUserWalletBalanceUseCase.call(NoParams());
    result.fold((l) {
      emit(GetOfferByIdFailure(message: l.message ?? 'Something went wrong!'));
    }, (r) {
      emit(GetUserWalletBalanceSuccessState(data: r.data));
    });
  }

  void categoryFilterLevel1Changed(String categoryLevel1) {
    _getAllOffersEntity =
        _getAllOffersEntity.copyWith(categoryLevel1: categoryLevel1);
  }

  void categoryFilterLevel2Changed(String categoryLevel2) {
    _getAllOffersEntity =
        _getAllOffersEntity.copyWith(categoryLevel2: categoryLevel2);
  }

  void categoryFilterLevel3Changed(String categoryLevel3) {
    _getAllOffersEntity =
        _getAllOffersEntity.copyWith(categoryLevel3: categoryLevel3);
  }

  void productFilterCategoryChanged(String productCategory) {
    _getAllOffersEntity =
        _getAllOffersEntity.copyWith(productId: productCategory);
  }

  void stateFilterChanged(String state) {
    _getAllOffersEntity = _getAllOffersEntity.copyWith(stateId: state);
  }

  void cityFilterChanged(String city) {
    _getAllOffersEntity = _getAllOffersEntity.copyWith(talukaId: city);
  }

  void talukaFilterChanged(String taluka) {
    _getAllOffersEntity = _getAllOffersEntity.copyWith(talukaId: taluka);
  }

  void resetCategoryFilters() {
    _getAllOffersEntity = _getAllOffersEntity.clearCategoriesFilters();
    getAllBOffers();
  }

  void resetStateFilters() {
    _getAllOffersEntity = _getAllOffersEntity.clearStateFilters();
    getAllBOffers();
  }

  void appCategoryFilters() {
    getAllBOffers();
  }

  void appStateFilter() {
    getAllBOffers();
  }

  void offerBuySellChanged(ProductType type) {
    entity = entity.copyWith(offerBuySell: type.value);
  }

  void offerTypeChanged(OfferType type) {
    emit(Trying());
    entity = entity.copyWith(offerType: type.value);
    emit(OffersInitial());
  }

  void businessIdChanged(BusinessModel business) {
    selectedBusiness = business;
    entity = entity.copyWith(businessId: business.id);
  }

  void offerTitleChanged(List<OfferTitleEntity> offerTitle) {
    entity = entity.copyWith(offerTitle: offerTitle);
  }

  void categoryLevel1Changed(String categoryLevel1) {
    entity = entity.copyWith(categoryLevel1: categoryLevel1);
  }

  void categoryLevel2Changed(String categoryLevel2) {
    entity = entity.copyWith(categoryLevel2: categoryLevel2);
  }

  void categoryLevel3Changed(String categoryLevel3) {
    entity = entity.copyWith(categoryLevel3: categoryLevel3);
  }

  void productCategoryChanged(String productCategory) {
    entity = entity.copyWith(productId: productCategory);
  }

  void targetAllAgesChanged(bool targetAllAges) {
    emit(Trying());
    entity = entity.copyWith(targetAllAges: targetAllAges);
    emit(OffersInitial());
  }

  void fromAgeChanged(String fromAge) {
    entity = entity.copyWith(fromAge: fromAge);
  }

  void toAgeChanged(String toAge) {
    entity = entity.copyWith(toAge: toAge);
  }

  void targetSexChanged(String targetSex) {
    entity = entity.copyWith(targetSex: targetSex);
  }

  void locationChanged(String location) {
    entity = entity.copyWith(location: location);
  }

  void coinsChanged(int coins) {
    entity = entity.copyWith(coins: coins.toString());
  }

  void startDateChanged(String startDate) {
    entity = entity.copyWith(startDate: startDate);
  }

  void endDateChanged(String endDate) {
    entity = entity.copyWith(endDate: endDate);
  }

  void imageChanged(File image) {
    entity = entity.copyWith(image: image);
  }

  void productIdChanged(String productId) {
    entity = entity.copyWith(productId: productId);
  }

  void originalPriceChanged(String originalPrice) {
    entity = entity.copyWith(originalPrice: originalPrice);
  }

  void offerPriceChanged(String offerPrice) {
    entity = entity.copyWith(offerPrice: offerPrice);
  }

  void categoryLevel4Changed(String categoryLevel4) {
    entity = entity.copyWith(categoryLevel4: categoryLevel4);
  }

  CreateOfferEntity getEntity() {
    return entity;
  }

  Future<void> getAllBOffers({bool? isOptimisticUpdate = false}) async {
    if (!isOptimisticUpdate!) {
      emit(GetAllOffersLoading());
    } else {
      emit(OffersOptimisticState());
    }

    final result = await _allOffersUseCase.call(_getAllOffersEntity);
    result.fold(
      (failure) {
        debugPrint(failure.toString());

        emit(
          GetAllOffersFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        emit(
          GetAllOffersSuccessState(
            data: response.data ?? [],
          ),
        );
      },
    );
  }

  Future<void> deleteOffer(String offerId) async {
    emit(DeleteOfferLoadingState());
    final result = await _deleteOfferUseCase.call(offerId);
    result.fold(
      (failure) {
        emit(DeleteOfferFailureState(
            message: failure.message ?? 'Failed to delete offer.'));
      },
      (response) {
        emit(DeleteOfferSuccessState(
            message: response.message ?? 'Offer deleted successfully.'));
      },
    );
  }
}
