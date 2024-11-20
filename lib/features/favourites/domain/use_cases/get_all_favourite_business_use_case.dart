import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/favourites/data/repository/favourite_repository.dart';

class FetchFavouriteBusinessUseCase
    implements UseCase<ApiBaseResponse<List<BusinessModel>>, NoParams> {
  final FavouritesRepository _favouritesRepository;

  FetchFavouriteBusinessUseCase({
    required FavouritesRepository favouritesRepository,
  }) : _favouritesRepository = favouritesRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<BusinessModel>>>> call(
      NoParams params) {
    return _favouritesRepository.fetchFavouriteBusinesses();
  }
}
