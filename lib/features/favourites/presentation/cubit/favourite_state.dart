part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class OptimisticState extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteBusinessLoaded extends FavouriteState {
  final List<BusinessModel> businesses;

  const FavouriteBusinessLoaded({required this.businesses});

  @override
  List<Object> get props => [businesses];
}

class FavouriteOffersLoaded extends FavouriteState {
  final List<OfferModel> offers;

  const FavouriteOffersLoaded({required this.offers});

  @override
  List<Object> get props => [offers];
}

class FavouriteError extends FavouriteState {
  final String message;

  const FavouriteError({required this.message});

  @override
  List<Object> get props => [message];
}
