import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_my_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_card.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOffersScreen extends StatefulWidget {
  const MyOffersScreen({super.key});

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  late OffersCubit _offersCubit;
  int index = 0;
  @override
  void initState() {
    _offersCubit = sl<OffersCubit>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _offersCubit.getMyOffers(GetMyOffersEntity(search: 'Live'));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'My Offers',
      floatingActionButton: CustomFloatingActionButton(
          onPressed: () => {
                CustomNavigator.pushTo(context, AppRouter.createOfferFormScreen)
              },
          label: 'Create New Offer',
          icon: Icons.add),
      body: BlocConsumer<OffersCubit, OffersState>(
        bloc: _offersCubit,
        listener: (context, state) {
          if (state is GetAllOffersFailure) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is GetAllOffersSuccessState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  CustomSpacers.height20,
                  CustomTabWidget(
                    tabWidth: 280,
                    initialIndex: index,
                    onValueChange: (val) {
                      setState(() {
                        index = val;
                      });
                      _offersCubit.getMyOffers(GetMyOffersEntity(
                          search: val == 0 ? 'Live' : 'Expired'));
                    },
                    options: const {'Active', 'Previous'},
                    optionWidth: 129,
                  ),
                  CustomSpacers.height20,
                  if (state.data.isNotEmpty)
                    for (var offer in state.data) ...[
                      MyOfferCard(
                        onTap: () {
                          CustomNavigator.pushTo(
                            context,
                            AppRouter.offerDetailScreen,
                            arguments: offer,
                          );
                        },
                        offerModel: offer,
                      ),
                      CustomSpacers.height20,
                    ]
                  else
                    Center(
                      child: Text(
                        'No offers found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                ],
              ),
            );
          }

          return const Loading();
        },
      ),
    );
  }
}
