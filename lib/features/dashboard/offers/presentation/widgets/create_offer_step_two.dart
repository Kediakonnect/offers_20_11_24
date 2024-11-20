import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/profile_picture_selector.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_form_validators.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offers_category_drop_downs.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateOfferStepTwo extends StatefulWidget {
  final VoidCallback onBackPressed, onNextPressed;
  final OffersCubit cubit;

  const CreateOfferStepTwo(
      {super.key,
      required this.onBackPressed,
      required this.onNextPressed,
      required this.cubit});

  @override
  State<CreateOfferStepTwo> createState() => _CreateOfferStepTwoState();
}

class _CreateOfferStepTwoState extends State<CreateOfferStepTwo>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _categoryTC,
      _productNameTC,
      _originalPriceTC,
      _offerPriceTC;
  late OffersCubit _offersCubit;
  late BusinessCategoryCubit _businessCategoryCubit;

  final CategoryEntity _categoryEntity = CategoryEntity(
    categorylevel: 1,
    level1Id: null,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _offersCubit = widget.cubit;
    _businessCategoryCubit = sl<BusinessCategoryCubit>();

    _categoryTC = TextEditingController();

    _productNameTC = TextEditingController();

    _originalPriceTC = TextEditingController();

    _offerPriceTC = TextEditingController();

    _offerPriceTC.text = _offersCubit.selectedOffer?.offerPrice ?? '';
    _originalPriceTC.text = _offersCubit.selectedOffer?.originalPrice ?? '';
    _productNameTC.text = _offersCubit.selectedOffer?.productName ?? '';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _categoryEntity = CategoryEntity(
      //   categorylevel: 4,
      //   level3Id: _offersCubit.getEntity().productCategory,
      // );
      _businessCategoryCubit.getCategories(_categoryEntity);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: FigmaValueConstants.defaultPaddingH.w - 10.w),
      child: BlocConsumer<OffersCubit, OffersState>(
        bloc: _offersCubit,
        listener: (context, state) {
          if (state is CreateOfferSuccessState) {
            CustomNavigator.pushReplace(context, AppRouter.offersScreen);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                CustomSpacers.height40,
                OffersCategoriesDropDown(
                  offersCubit: _offersCubit,
                  isBuy: _offersCubit.entity.offerBuySell == 'sell',
                  categories: _offersCubit.entity.offerBuySell == 'sell'
                      ? _offersCubit.selectedBusiness?.categoryLevel3
                      : null,
                ),
                CustomSpacers.height20,
                ProfilePicViewerOrSelectorWidget(
                  isEditable: true,
                  defaultImage: _offersCubit.entity.image,
                  onChanged: (file) {
                    if (file != null) {
                      _offersCubit.imageChanged(file);
                    }
                  },
                  label: 'Upload offer Image',
                  changeImageText: 'Upload Offer Image',
                ),
                CustomSpacers.height20,
                CustomTextField(
                  hintText: 'Product name',
                  onChanged: (val) => _offersCubit.productIdChanged(val),
                  controller: _productNameTC,
                ),
                CustomSpacers.height20,
                CustomTextField(
                  validator: (val) => OffersValidators.validateOriginalPrice(
                    _originalPriceTC.text.isEmpty
                        ? null
                        : _originalPriceTC.text,
                  ),
                  onChanged: (val) => _offersCubit.originalPriceChanged(val),
                  hintText: 'Original price',
                  controller: _originalPriceTC,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                ),
                CustomSpacers.height20,
                Visibility(
                  visible: _offersCubit.entity.offerBuySell == 'sell',
                  child: CustomTextField(
                    hintText: 'Offer price',
                    validator: (val) =>
                        OffersValidators.validateOfferPrice(val),
                    controller: _offerPriceTC,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                ),
                CustomSpacers.height40,
                CustomButton(
                  isLoading: state is CreateOfferLoadingState,
                  onPressed: () async {
                    // Check if the image is null
                    if (_offersCubit.entity.image == null) {
                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please upload an offer image'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Prevent further execution
                    }

                    // Proceed with form validation and creation
                    if (_formKey.currentState!.validate()) {
                      await _offersCubit.createOffer(
                        widget.cubit.selectedOffer != null
                            ? CreateOfferType.updateOffer
                            : CreateOfferType.newOffer,
                      );
                    }
                  },
                  btnText: 'Next',
                ),
                CustomSpacers.height20,
                GoBackButton(onTap: widget.onBackPressed),
                CustomSpacers.height120,
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
