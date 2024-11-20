part of 'state_selector_cubit.dart';

sealed class StateSelectorState extends Equatable {
  const StateSelectorState();

  @override
  List<Object> get props => [];
}

final class Trying extends StateSelectorState {}

final class StatesIntialState extends StateSelectorState {}

final class StatesLoadingState extends StateSelectorState {}

final class GetStatesSuccessState extends StateSelectorState {}

final class EditBusinessSuccess extends StateSelectorState {
  final List<StateModel> states;

  const EditBusinessSuccess({required this.states});
}

final class FilterStateSuccessState extends StateSelectorState {
  final StateModel state;

  const FilterStateSuccessState({required this.state});
}

final class FilterDistrictSuccessState extends StateSelectorState {}

final class FilterTalukaSuccessState extends StateSelectorState {}

final class StatesFailureState extends StateSelectorState {
  final String message;

  const StatesFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
