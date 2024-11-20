import 'dart:convert';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/helpers/string.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_offer_by_id_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/gender_enums.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_enums.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_form_validators.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_type_enum.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offers_language_form.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/checkbox_treeview.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewOfferStepOne extends StatefulWidget {
  final VoidCallback onBackPressed, onNextPressed;
  final BusinessCategoryCubit businessCategoryCubit;
  final OfferModel? offerModel;
  final OffersCubit cubit;
  const CreateNewOfferStepOne(
      {super.key,
      required this.onBackPressed,
      this.offerModel,
      required this.onNextPressed,
      required this.businessCategoryCubit,
      required this.cubit});

  @override
  State<CreateNewOfferStepOne> createState() => _CreateNewOfferStepOneState();
}

// ignore: must_be_immutable
class _CreateNewOfferStepOneState extends State<CreateNewOfferStepOne>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _busnessNameTC,
      _offerTypeTC,
      _buyAndSellOfferTC,
      _offerTitleTC,
      _offerdescriptionTC,
      _categoryTC,
      _fromAgeTC,
      _toAgeTC,
      _startDateTC,
      _endDateTC,
      _categoryLevel3TC;

  late GlobalKey<FormState> _formKey;

  final CategoryEntity _categoryEntity = CategoryEntity(
    categorylevel: 3,
    level1Id: null,
  );

  late OffersCubit _offersCubit;
  late BusinessCategoryCubit _businessCategoryCubit;
  late List<TreeNode> nodes;
  late StateSelectorCubit _stateSelectorCubit;

  Set<String> selectedLanguages = {};

  @override
  void initState() {
    _offersCubit = widget.cubit;
    _businessCategoryCubit = widget.businessCategoryCubit;
    _formKey = GlobalKey<FormState>();
    _stateSelectorCubit = sl<StateSelectorCubit>();
    nodes = [];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _offersCubit.getMyBusiness();
      _stateSelectorCubit.getStates(shouldRefetch: true);

      if (widget.offerModel != null) {
        _offersCubit.getOfferById(
            entity: GetOfferByIdEntity(id: widget.offerModel?.id ?? ''));
      }
    });
    _busnessNameTC = TextEditingController();
    _offerTypeTC = TextEditingController();
    _buyAndSellOfferTC = TextEditingController();
    _offerTitleTC = TextEditingController();
    _offerdescriptionTC = TextEditingController();
    _categoryTC = TextEditingController();
    _fromAgeTC = TextEditingController();
    _toAgeTC = TextEditingController();
    _startDateTC = TextEditingController();
    _endDateTC = TextEditingController();
    _categoryLevel3TC = TextEditingController();

    _startDateTC.text = widget.offerModel?.startDate ?? '';
    _endDateTC.text = widget.offerModel?.endDate ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _busnessNameTC.dispose();
    _offerTypeTC.dispose();
    _buyAndSellOfferTC.dispose();
    _offerTitleTC.dispose();
    _offerdescriptionTC.dispose();
    _categoryTC.dispose();
    _fromAgeTC.dispose();
    _toAgeTC.dispose();
    _startDateTC.dispose();
    _endDateTC.dispose();

    super.dispose();
  }

  int _getOfferRate(OfferRateModel? offerModel) {
    if (offerModel == null) return 0;

    switch (_offersCubit.entity.offerType) {
      case "b2b":
        return offerModel.b2bRate.toInt();

      case "entry":
        return offerModel.entryRate.toInt();

      case "exit":
        return offerModel.exitRate.toInt();

      case "screen":
        return offerModel.regularRate.toInt();

      case "banner":
        return offerModel.bannerRate.toInt();
      default:
        return offerModel.regularRate.toInt();
    }
  }

  List<TreeNode> _mapStateModelToTreeNodes(
      List<StateModel> stateModelResponse, List<Location> selectedLocation) {
    return [
      TreeNode(
        label: "All India",
        id: "India",
        isChecked: selectedLocation.isNotEmpty,
        children: stateModelResponse.map((state) {
          bool isStateSelected =
              selectedLocation.any((element) => element.state.id == state.id);

          if (isStateSelected) {
            debugPrint("Selected state: ${state.name}");
          }

          return TreeNode(
            isChecked: isStateSelected,
            id: state.id,
            label: state.name,
            children: state.districts.map((district) {
              bool isDistrictSelected = selectedLocation.any((location) =>
                  location.districts.any((districtElement) =>
                      districtElement.id.id == district.id));

              if (isDistrictSelected) {
                debugPrint("Selected state: ${district.name}");
              }

              return TreeNode(
                isChecked: isDistrictSelected,
                id: district.id,
                label: district.name,
                children: district.talukas.map((taluka) {
                  bool isTalukaSelected = selectedLocation.any((location) =>
                      location.districts.any((districtElement) =>
                          districtElement.taluakas.any((talukaElement) =>
                              talukaElement.id == taluka.id)));

                  if (isTalukaSelected) {
                    debugPrint("Selected state: ${taluka.name}");
                  }
                  return TreeNode(
                    isChecked: isTalukaSelected,
                    id: taluka.id,
                    label: taluka.name,
                    userCount: taluka.userCount,
                    offerRate: _getOfferRate(taluka.offerRate),
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
      ),
    ];
  }

  List<TreeNode> getDefaultSelectedNodes(List<Location> statesModelResponse) {
    return [
      TreeNode(
          label: "All India",
          id: "India",
          children: statesModelResponse.map((state) {
            return TreeNode(
              id: state.state.id,
              label: state.state.name,
              children: state.districts.map((district) {
                return TreeNode(
                  id: district.id.id,
                  label: district.id.name,
                  children: district.taluakas.map((taluka) {
                    return TreeNode(
                      id: taluka.id,
                      label: taluka.name,
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }).toList()),
    ];
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Customize as needed
      lastDate:
          DateTime.now().add(const Duration(days: 90)), // Customize as needed
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      controller.text = formattedDate;
      if (controller == _startDateTC) {
        _offersCubit.startDateChanged(formattedDate);
      } else {
        _offersCubit.endDateChanged(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<OffersCubit, OffersState>(
      bloc: _offersCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: FigmaValueConstants.defaultPaddingH.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSpacers.height20,
                _buildBusinessNameDropDown(),
                CustomSpacers.height20,
                CustomDropDown(
                  groupValue: _offersCubit.entity.offerType.offerType?.label,
                  validator: (val) => OffersValidators.validateOfferType(val),
                  options: OfferType.values.map((e) => e.label).toList(),
                  onChanged: (idx) {
                    _offersCubit.offerTypeChanged(OfferType.values[idx!]);
                  },
                  controller: _offerTypeTC,
                  hintText: 'Offer type (entry screen)',
                ),
                CustomSpacers.height20,
                CustomDropDown(
                  groupValue:
                      _offersCubit.entity.offerBuySell.productType?.label,
                  validator: (val) =>
                      OffersValidators.validateBuyAndSellOffer(val),
                  options: ProductType.values
                      .map((e) => e.value.toCapitalized)
                      .toList(),
                  controller: _buyAndSellOfferTC,
                  onChanged: (idx) {
                    _offersCubit.offerBuySellChanged(ProductType.values[idx!]);
                  },
                  hintText: 'Buy offer / Sell offer',
                ),
                CustomSpacers.height20,
                // if (state is UpdateFormSuccessState) ...[
                OffersLanguageForm(
                  offerTitle: _offersCubit.selectedOffer?.offerTitle
                          .map((e) => e.toEntity())
                          .toList() ??
                      [],
                  onLanguagesChanged: (val) {
                    _offersCubit.offerTitleChanged(val);
                  },
                ),
                CustomSpacers.height20,
                // ],
                CustomCheckBoxTile(
                  value: _offersCubit.entity.targetAllAges,
                  onChanged: (v) {
                    _offersCubit.targetAllAgesChanged(v ?? false);
                  },
                  option: 'Target all ages',
                ),
                CustomSpacers.height20,
                _buildAgeDropDown(),
                CustomSpacers.height20,
                CustomDropDown(
                  groupValue: _offersCubit.entity.targetSex.genderType?.label,
                  validator: (val) => widget.cubit.entity.targetAllAges
                      ? null
                      : OffersValidators.validateSex(val),
                  onChanged: (isx) {
                    _offersCubit.targetSexChanged(
                        Gendertypes.values.map((e) => e.value).toList()[isx!]);
                  },
                  options: Gendertypes.values.map((e) => e.label).toList(),
                  controller: _toAgeTC,
                  hintText: 'Target sex',
                ),
                _buildStatesSelector(),
                CustomSpacers.height12,
                GestureDetector(
                  onTap: () => _selectDate(context, _startDateTC),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: 'Start date (optional)',
                      controller: _startDateTC,
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                CustomSpacers.height20,
                GestureDetector(
                  onTap: () => _selectDate(context, _endDateTC),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: 'End date (optional)',
                      controller: _endDateTC,
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                CustomSpacers.height20,

                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Age validation
                      if (int.parse(widget.cubit.entity.fromAge ?? '0') >
                          int.parse(widget.cubit.entity.toAge ?? '0')) {
                        ScaffoldHelper.showFailureSnackBar(
                          context: context,
                          message:
                              'From age should be less than or equal to To age',
                        );
                        return;
                      }

                      // Location validation
                      if (widget.cubit.entity.location.isEmpty) {
                        ScaffoldHelper.showFailureSnackBar(
                          context: context,
                          message: 'Please select location',
                        );
                        return;
                      }

                      // Start date must be today or later
                      if (widget.cubit.entity.startDate != null) {
                        try {
                          final startDate =
                              DateTime.parse(widget.cubit.entity.startDate!);
                          final today = DateTime.now();

                          if (startDate.isBefore(
                              DateTime(today.year, today.month, today.day))) {
                            ScaffoldHelper.showFailureSnackBar(
                              context: context,
                              message:
                                  'Start date must be today or a future date',
                            );
                            return;
                          }
                        } catch (e) {
                          ScaffoldHelper.showFailureSnackBar(
                            context: context,
                            message: 'Invalid date format for start date',
                          );
                          return;
                        }
                      }

                      if (widget.cubit.entity.startDate != null &&
                          widget.cubit.entity.endDate == null) {
                        ScaffoldHelper.showFailureSnackBar(
                          context: context,
                          message: 'Please select end date',
                        );
                        return;
                      }
                      if (widget.cubit.entity.startDate == null &&
                          widget.cubit.entity.endDate != null) {
                        ScaffoldHelper.showFailureSnackBar(
                          context: context,
                          message: 'Please select Start date',
                        );
                        return;
                      }

                      if (widget.cubit.entity.startDate != null &&
                          widget.cubit.entity.endDate != null) {
                        try {
                          final startDate = DateTime.parse(
                              widget.cubit.entity.startDate ?? '');
                          final endDate =
                              DateTime.parse(widget.cubit.entity.endDate ?? '');

                          if (endDate.isBefore(startDate)) {
                            ScaffoldHelper.showFailureSnackBar(
                              context: context,
                              message:
                                  'End date must be greater than or equal to the start date',
                            );
                            return;
                          }
                        } catch (e) {
                          ScaffoldHelper.showFailureSnackBar(
                            context: context,
                            message: 'Invalid date format',
                          );
                          return;
                        }
                      }

                      // If all validations pass, proceed to the next step
                      widget.onNextPressed();
                    }
                  },
                  btnText: 'Next',
                ),

                CustomSpacers.height20,
                GoBackButton(onTap: () {
                  widget.onBackPressed();
                }),
                CustomSpacers.height120,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatesSelector() {
    return MultiBlocListener(
      listeners: [
        BlocListener<StateSelectorCubit, StateSelectorState>(
          bloc: _stateSelectorCubit,
          listener: (context, state) {
            if (state is StatesFailureState) {
              ScaffoldHelper.showFailureSnackBar(
                  context: context, message: state.message);
            }

            if (state is GetStatesSuccessState) {
              // Ensure nodes are updated on successful state fetching
              nodes =
                  _mapStateModelToTreeNodes(_stateSelectorCubit.allStates, []);
            }
          },
        ),
        BlocListener<OffersCubit, OffersState>(
          bloc: _offersCubit,
          listener: (context, state) {
            if (state is FilterStateSuccessState) {
              nodes =
                  _mapStateModelToTreeNodes(_stateSelectorCubit.allStates, []);
            } else if (state is GetOfferByIdSuccessState) {
              nodes = _mapStateModelToTreeNodes(
                _stateSelectorCubit.allStates,
                state.data?.location ?? [],
              );

              nodes.forEach(_onNodeCheckChanged);
            }
          },
        ),
      ],
      child: BlocBuilder<StateSelectorCubit, StateSelectorState>(
        bloc: _stateSelectorCubit,
        builder: (context, state) {
          return BlocBuilder<OffersCubit, OffersState>(
            bloc: _offersCubit,
            builder: (context, offerState) {
              if (state is StatesFailureState) {
                return Center(
                    child: Text('Failed to load states: ${state.message}'));
              }

              // Ensure states are shown whenever nodes are not empty
              if (nodes.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomSpacers.height21,
                      CheckboxTreeWidget(
                        nodes: nodes,
                        onNodeCheckChanged: _onNodeCheckChanged,
                      ),
                    ],
                  ),
                );
              }

              // Show loading indicator only if states are still loading
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorPalette.primaryColor,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAgeDropDown() {
    return BlocBuilder<OffersCubit, OffersState>(
      bloc: _offersCubit,
      builder: (context, state) {
        return Visibility(
          visible: !_offersCubit.entity.targetAllAges,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomDropDown(
                  groupValue: _offersCubit.entity.fromAge,
                  validator: (val) => OffersValidators.validateFromAge(val),
                  options:
                      List.generate(100, (index) => (index + 1).toString()),
                  onChanged: (age) {
                    _offersCubit.fromAgeChanged((age! + 1).toString());
                  },
                  controller: _fromAgeTC,
                  hintText: 'From age',
                ),
              ),
              CustomSpacers.width20,
              Expanded(
                child: CustomDropDown(
                  groupValue: _offersCubit.entity.toAge,
                  validator: (val) => widget.cubit.entity.targetAllAges
                      ? null
                      : OffersValidators.validateToAge(val),
                  onChanged: (age) {
                    _offersCubit.toAgeChanged((age! + 1).toString());
                  },
                  options:
                      List.generate(100, (index) => (index + 1).toString()),
                  controller: _toAgeTC,
                  hintText: 'To age',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBusinessNameDropDown() {
    return BlocBuilder<OffersCubit, OffersState>(
      bloc: _offersCubit,
      buildWhen: (previous, current) =>
          current is GetMyBusinessSuccessState ||
          current is GetMyBusinessFailure ||
          current is GetMyBusinessLoadingState,
      builder: (context, state) {
        return CustomDropDown(
          groupValue: _offersCubit.selectedOffer?.businessId?.name,
          options: _offersCubit.myBusinesses.map((e) => e.name).toList(),
          controller: _busnessNameTC,
          disabled: _offersCubit.myBusinesses.isEmpty,
          validator: (value) => OffersValidators.validateBusinessName(value),
          hintText: state is GetMyBusinessLoadingState
              ? 'Getting Business Name...'
              : _offersCubit.myBusinesses.isEmpty
                  ? 'No Business Found'
                  : 'Select Business',
          onChanged: (index) {
            _offersCubit.businessIdChanged(_offersCubit.myBusinesses[index!]);

            if (_offersCubit.selectedBusiness != null) {
              debugPrint(_offersCubit.selectedBusiness?.name);

              _businessCategoryCubit.selectProduct(
                categoryLevel1:
                    _offersCubit.selectedBusiness!.categoryLevel1.id,
                categoryLevel2:
                    _offersCubit.selectedBusiness!.categoryLevel2.id,
                categoryLevel3:
                    _offersCubit.selectedBusiness!.categoryLevel3.first.id,
              );
            }
          },
        );
      },
    );
  }

  void _onNodeCheckChanged(TreeNode node) {
    int checkedOfferRate = 0;
    List<Map<String, dynamic>> selectedItems = [];

    for (var stateNode in nodes[0].children) {
      if (stateNode.isChecked) {
        Map<String, dynamic> selectedState = {
          "state": stateNode.id,
          "districts": []
        };

        for (var districtNode in stateNode.children) {
          if (districtNode.isChecked) {
            Map<String, dynamic> selectedDistrict = {
              "id": districtNode.id,
              "taluakas": [] // Fixed typo
            };

            for (var talukaNode in districtNode.children) {
              if (talukaNode.isChecked) {
                selectedDistrict["taluakas"]?.add(talukaNode.id);

                if (talukaNode.offerRate != null) {
                  checkedOfferRate += talukaNode.offerRate!;
                }
              }
            }

            if (selectedDistrict["taluakas"]!.isNotEmpty) {
              selectedState["districts"]?.add(selectedDistrict);
            }
          }
        }

        if (selectedState["districts"]!.isNotEmpty) {
          selectedItems.add(selectedState);
        }
      }
    }
    _offersCubit.locationChanged(jsonEncode(selectedItems));
    _offersCubit.coinsChanged(checkedOfferRate);
  }

  @override
  bool get wantKeepAlive => true;
}
