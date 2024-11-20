import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/gst_calculator_type.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateOfferStepFour extends StatefulWidget {
  final OffersCubit cubit;
  final VoidCallback onBackPressed, onSubmit;
  const CreateOfferStepFour(
      {super.key,
      required this.onBackPressed,
      required this.onSubmit,
      required this.cubit});

  @override
  State<CreateOfferStepFour> createState() => _CreateOfferStepFourState();
}

class _CreateOfferStepFourState extends State<CreateOfferStepFour> {
  late OffersCubit _offersCubit;

  @override
  void initState() {
    _offersCubit = widget.cubit;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _offersCubit.getUserWalletBalance();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OffersCubit, OffersState>(
      bloc: _offersCubit,
      listener: (context, state) {
        if (state is CreateOfferSuccessState) {
          CustomNavigator.pushReplace(context, AppRouter.offersScreen);
        }
      },
      builder: (context, state) {
        if (state is GetUserWalletBalanceSuccessState) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: FigmaValueConstants.defaultPaddingH.w),
            child: Column(
              children: [
                CustomSpacers.height20,
                CustomCheckBoxTile(
                    onChanged: (v) {},
                    value: true,
                    option:
                        'All Locations - ${widget.cubit.entity.coins} Coins'),
                CustomSpacers.height30,
                CustomTextField(
                  hintText: 'Max Recharge Coins to be spent',
                  controller: TextEditingController(),
                ),
                CustomSpacers.height30,
                Text(
                  'Available Recharge Coins Balance',
                  style: AppTextThemes.theme(context).headlineLarge,
                ),
                CustomSpacers.height20,
                Text(state.data!.balance.toString(),
                    style: AppTextThemes.theme(context).displayLarge),
                CustomSpacers.height30,
                GestureDetector(
                  onTap: () => CustomNavigator.pushTo(
                    context,
                    AppRouter.diamondCoinScreen,
                    arguments: GSTCalculatorType.purchaseCoins,
                  ),
                  child: const NeuroMorphicText(
                    text: 'Get More Recharge Coins',
                  ),
                ),
                CustomSpacers.height30,
                Text('(1 Recharge Coin = 1 Rupee)',
                    style: AppTextThemes.theme(context).titleLarge),
                CustomSpacers.height30,
                Text(
                  'Available Bonus Diamonds',
                  style: AppTextThemes.theme(context).headlineLarge,
                ),
                CustomSpacers.height20,
                Text('1500', style: AppTextThemes.theme(context).displayLarge),
                CustomSpacers.height30,
                GestureDetector(
                  onTap: () => CustomNavigator.pushTo(
                    context,
                    AppRouter.diamondCoinScreen,
                    arguments: GSTCalculatorType.diamondsToCoins,
                  ),
                  child: const NeuroMorphicText(
                    text: 'CONVERT Bonus Diamonds to Recharge Coins',
                  ),
                ),
                CustomSpacers.height30,
                Text('(1 Bonus Diamond = 1 Recharge Coin)',
                    style: AppTextThemes.theme(context).titleLarge),
                CustomSpacers.height24,
                const LabelValueWidget(
                  label: 'Note',
                  value:
                      'if you want to fix different view for different locations, you can create multiple ad campaigns with same content.Go to My Offers screen to reuse existing ad content in new campaigns.',
                ),
                CustomSpacers.height30,
                CustomTextField(
                  hintText: 'Referral ID / Mobile',
                  controller: TextEditingController(),
                ),
                CustomSpacers.height30,
                CustomButton(
                  isLoading: state is CreateOfferLoadingState,
                  onPressed: () async {
                    if (state.data!.balance <=
                        int.parse(_offersCubit.entity.coins)) {
                      await _offersCubit.createOffer(
                          widget.cubit.selectedOffer != null
                              ? CreateOfferType.updateOffer
                              : CreateOfferType.newOffer);
                    } else {
                      ScaffoldHelper.showFailureSnackBar(
                          context: context,
                          message: "Insufficient Recharge Coins Balance");
                    }
                  },
                  btnText: 'Submit',
                ),
                CustomSpacers.height20,
                GoBackButton(onTap: widget.onBackPressed),
                CustomSpacers.height120,
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: ColorPalette.primaryColor,
          ),
        );
      },
    );
  }
}
