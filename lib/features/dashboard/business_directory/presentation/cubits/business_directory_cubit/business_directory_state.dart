part of 'business_directory_cubit.dart';

sealed class BusinessDirectoryState extends Equatable {
  const BusinessDirectoryState();

  @override
  List<Object> get props => [];
}

final class OptimisticState extends BusinessDirectoryState {}

final class BusinessDirectoryInitial extends BusinessDirectoryState {}

final class BusinessDirectoryLoading extends BusinessDirectoryState {}

final class EditBusinessFormLoadingState extends BusinessDirectoryState {}

final class GetALlBusinessLoadingState extends BusinessDirectoryState {}

final class AddBusinessToFavoriteInitial extends BusinessDirectoryState {}

final class AddBusinessToFavoriteLoadingState extends BusinessDirectoryState {}

final class AddBusinessToFavoriteSuccessState extends BusinessDirectoryState {}

final class BusinessDirectorySuccess extends BusinessDirectoryState {
  final String message;

  const BusinessDirectorySuccess({required this.message});
}

final class RateBusinessSuccessState extends BusinessDirectoryState {}

final class BusinessDirectoryFailure extends BusinessDirectoryState {
  final String message;

  const BusinessDirectoryFailure({required this.message});
}

final class GetAllBusinessDirectoryFailure extends BusinessDirectoryState {
  final String message;

  const GetAllBusinessDirectoryFailure({required this.message});
}

final class GetAllBusinessSuccessState extends BusinessDirectoryState {
  final BusinessOfferListEntity data;

  const GetAllBusinessSuccessState({required this.data});
}

final class GetMyBusinessSuccessState extends BusinessDirectoryState {
  final List<BusinessModel> data;

  const GetMyBusinessSuccessState({required this.data});
}
