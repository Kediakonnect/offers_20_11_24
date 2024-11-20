part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

final class GetOfferLoadingState extends OnboardingState {}

final class GetOfferSuccessState extends OnboardingState {
  final OfferModel offerMode;

  const GetOfferSuccessState(this.offerMode);
}

final class GetOfferFailureState extends OnboardingState {}
