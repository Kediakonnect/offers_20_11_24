import 'package:bloc/bloc.dart';
import 'package:divyam_flutter/core/api/custom_client.dart';
import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  Future<void> getOffers(String offertype) async {
    emit(GetOfferLoadingState());
    try {
      final resp = await CustomHttpClient()
          .get(url: '$getRandomOffers?offer_type=$offertype');
      var map = resp.data['data']['offer'];
      var data = OfferModel.fromJson(map);
      emit(GetOfferSuccessState(data));
    } catch (e) {
      debugPrint(e.toString());
      emit(GetOfferFailureState());
    }
  }
}
