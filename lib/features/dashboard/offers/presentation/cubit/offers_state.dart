part of 'offers_cubit.dart';

sealed class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

final class OffersInitial extends OffersState {}

final class Trying extends OffersState {}

final class UpdateFormLoadingState extends OffersState {}

final class UpdateFormSuccessState extends OffersState {}

final class GetAllOffersLoading extends OffersState {}

final class GetMyBusinessLoadingState extends OffersState {}

final class CreateOfferLoadingState extends OffersState {}

final class ViewOfferLoadingState extends OffersState {}

final class AddOffersToFavoriteInitial extends OffersState {}

final class GetOfferByIdInitial extends OffersState {}

final class AddOffersToFavoriteLoadingState extends OffersState {}

final class AddOffersToFavoriteSuccessState extends OffersState {}

final class OffersOptimisticState extends OffersState {}

final class GetAllOffersFailure extends OffersState {
  final String message;

  const GetAllOffersFailure({required this.message});
}

final class ViewOffersFailure extends OffersState {
  final String message;

  const ViewOffersFailure({required this.message});
}

final class GetOfferByIdFailure extends OffersState {
  final String message;

  const GetOfferByIdFailure({required this.message});
}

final class CreateOfferFailure extends OffersState {
  final String message;

  const CreateOfferFailure({required this.message});
}

final class CreateOfferSuccessState extends OffersState {
  const CreateOfferSuccessState();
}

final class ViewOfferSuccessState extends OffersState {
  const ViewOfferSuccessState();
}

final class GetMyBusinessFailure extends OffersState {
  final String message;

  const GetMyBusinessFailure({required this.message});
}

final class GetMyBusinessSuccessState extends OffersState {
  final List<BusinessModel> data;

  const GetMyBusinessSuccessState({required this.data});
}

final class GetAllOffersSuccessState extends OffersState {
  final List<OfferModel> data;

  const GetAllOffersSuccessState({required this.data});
}

final class GetOfferByIdSuccessState extends OffersState {
  final OfferModel? data;

  const GetOfferByIdSuccessState({required this.data});
}

final class GetUserWalletBalanceSuccessState extends OffersState {
  final WalletModel? data;

  const GetUserWalletBalanceSuccessState({required this.data});
}

class DeleteOfferLoadingState extends OffersState {}

class DeleteOfferSuccessState extends OffersState {
  final String message;
  const DeleteOfferSuccessState({required this.message});
}

class DeleteOfferFailureState extends OffersState {
  final String message;
  const DeleteOfferFailureState({required this.message});
}
