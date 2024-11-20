import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_preview_card.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewOfferStepThree extends StatefulWidget {
  final VoidCallback onBackPressed, onNextPressed;
  final OffersCubit cubit;

  const CreateNewOfferStepThree(
      {super.key,
      required this.onBackPressed,
      required this.onNextPressed,
      required this.cubit});

  @override
  State<CreateNewOfferStepThree> createState() =>
      _CreateNewOfferStepThreeState();
}

class _CreateNewOfferStepThreeState extends State<CreateNewOfferStepThree> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: FigmaValueConstants.defaultPaddingH.w - 10.w),
      child: Column(
        children: [
          CustomSpacers.height20,
          OfferPreviewCard(
            cubit: widget.cubit,
          ),
          CustomSpacers.height20,
          CustomButton(onPressed: widget.onNextPressed, btnText: 'Next'),
          CustomSpacers.height20,
          GoBackButton(onTap: widget.onBackPressed),
          CustomSpacers.height120,
        ],
      ),
    );
  }
}
