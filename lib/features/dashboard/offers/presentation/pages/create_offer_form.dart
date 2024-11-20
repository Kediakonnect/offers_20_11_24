import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/create_new_offer_step_four.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/create_new_offer_step_one.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/create_offer_step_two.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_preview_widget.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CreateOfferType { newOffer, updateOffer }

extension CreateOfferTypeExtension on CreateOfferType {
  String get url {
    switch (this) {
      case CreateOfferType.newOffer:
        return createOfferUrl;
      case CreateOfferType.updateOffer:
        return updateOfferUrl;
    }
  }

  String get title {
    switch (this) {
      case CreateOfferType.newOffer:
        return 'Create Offer';
      case CreateOfferType.updateOffer:
        return 'Update Offer';
    }
  }

  String get successMessage {
    switch (this) {
      case CreateOfferType.newOffer:
        return 'Offer created successfully';
      case CreateOfferType.updateOffer:
        return 'Offer updated successfully';
    }
  }

  String get errorMessage {
    switch (this) {
      case CreateOfferType.newOffer:
        return 'Failed to create offer';
      case CreateOfferType.updateOffer:
        return 'Failed to update offer';
    }
  }

  bool get isUpdate => this == CreateOfferType.updateOffer;
}

class CreateOfferFormScreen extends StatefulWidget {
  final CreateOfferType? createOfferType;
  final OfferModel? offer;
  const CreateOfferFormScreen(
      {super.key, this.offer, this.createOfferType = CreateOfferType.newOffer});

  @override
  State<CreateOfferFormScreen> createState() => _CreateOfferFormScreenState();
}

class _CreateOfferFormScreenState extends State<CreateOfferFormScreen> {
  late PageController _pageController;
  late OffersCubit _offersCubit;

  late BusinessCategoryCubit _businessCategoryCubit;

  bool canPop = true;
  @override
  void initState() {
    _offersCubit = sl<OffersCubit>();
    _businessCategoryCubit = sl<BusinessCategoryCubit>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _offersCubit.createForm(widget.createOfferType!);
      if (widget.offer != null) {
        _offersCubit.update(widget.offer!);
        _businessCategoryCubit.updateCategories(widget.offer!);
      }
    });
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        canPop = _pageController.page == 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _offersCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (c) => _pageController.page == 0 ? null : onPrevious(),
      child: CustomScaffold(
        appBarTitle: widget.createOfferType!.title.toUpperCase(),
        body: BlocConsumer<OffersCubit, OffersState>(
          bloc: _offersCubit,
          listener: (context, state) {
            if (state is CreateOfferFailure) {
              ScaffoldHelper.showFailureSnackBar(
                context: context,
                message: state.message,
              );
            }
            if (state is CreateOfferSuccessState) {
              ScaffoldHelper.showSuccessSnackBar(
                context: context,
                message: widget.createOfferType!.successMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is UpdateFormLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CreateNewOfferStepOne(
                  offerModel: widget.offer,
                  businessCategoryCubit: _businessCategoryCubit,
                  cubit: _offersCubit,
                  onBackPressed: onPrevious,
                  onNextPressed: () {
                    onNext();
                  },
                ),
                CreateOfferStepTwo(
                  cubit: _offersCubit,
                  onBackPressed: onPrevious,
                  onNextPressed: () {
                    onNext();
                  },
                ),
                CreateNewOfferStepThree(
                  cubit: _offersCubit,
                  onBackPressed: onPrevious,
                  onNextPressed: () {
                    onNext();
                  },
                ),
                CreateOfferStepFour(
                  cubit: _offersCubit,
                  onBackPressed: onPrevious,
                  onSubmit: () {
                    // onNext();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPrevious() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
