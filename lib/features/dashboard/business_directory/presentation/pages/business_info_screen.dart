import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/enums/business_status.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/business_form_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_status.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/image_preview.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:divyam_flutter/ui/moleclues/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessInfoScreen extends StatefulWidget {
  final BusinessEntity businessEntity;

  const BusinessInfoScreen({super.key, required this.businessEntity});

  @override
  State<BusinessInfoScreen> createState() => _BusinessInfoScreenState();
}

class _BusinessInfoScreenState extends State<BusinessInfoScreen> {
  late BusinessDirectoryCubit _businessDirectoryCubit;

  @override
  void initState() {
    _businessDirectoryCubit = sl<BusinessDirectoryCubit>();

    super.initState();
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Business"),
          content: const Text(
              "Are you sure you want to delete this business? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: ColorPalette.primaryColor, // Set text color
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteBusiness(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: ColorPalette.primaryColor, // Set text color
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteBusiness(BuildContext context) {
    _businessDirectoryCubit
        .deleteBusiness(widget.businessEntity.businessId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomFloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessFormScreen(
                  businessFormType: BusinessFormType.edit,
                  businessEntity: widget.businessEntity,
                ),
              ),
            ),
            label: 'Edit Business',
          ),
          const SizedBox(width: 10), // Spacer between the buttons
          CustomFloatingActionButton(
            onPressed: () => _showDeleteConfirmationDialog(context),
            label: 'Delete Business',
            icon: Icons.delete, // Delete icon
            backgroundColor: ColorPalette.red,
          ),
        ],
      ),
      appBarTitle: 'My Business'.toUpperCase(),
      body: BlocConsumer<BusinessDirectoryCubit, BusinessDirectoryState>(
        bloc: _businessDirectoryCubit,
        listener: (context, state) {
          if (state is BusinessDirectoryFailure) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
          if (state is BusinessDirectorySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Business deleted successfully.'),
              ),
            );
            Navigator.pop(context);
            CustomNavigator.pushReplace(context, AppRouter.myBusinessScreen);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacers.height20,
                if (widget.businessEntity.isNeworkImages == true)
                  CustomSpacers.height20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.businessEntity.name,
                          style: AppTextThemes.theme(context).displayLarge,
                        ),
                        CustomSpacers.height10,
                        const BusinessStatusWidget(
                          status: BusinessStatusType
                              .live, // This should be dynamic based on the entity's status
                        ),
                        CustomSpacers.height10,
                        LabelValueWidget(
                            label: 'Mobile',
                            value: widget.businessEntity.mobile),
                        CustomSpacers.height10,
                      ],
                    ),
                    if (widget.businessEntity.logoImage != null)
                      ProfilePicture.network(
                        size: 100,
                        path: widget.businessEntity.logoImage ?? '',
                      ),
                  ],
                ),
                CustomSpacers.height10,
                Visibility(
                  visible: widget.businessEntity.whatsappNumber != null,
                  child: Column(
                    children: [
                      LabelValueWidget(
                        label: 'Whatsapp',
                        value: widget.businessEntity.whatsappNumber!,
                      ),
                      CustomSpacers.height10,
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.businessEntity.contactPerson.isNotEmpty,
                  child: Column(
                    children: [
                      LabelValueWidget(
                        label: 'Contact Person',
                        value: widget.businessEntity.contactPerson,
                      ),
                      CustomSpacers.height10,
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.businessEntity.stateValue != null,
                  child: Column(
                    children: [
                      LabelValueWidget(
                        label: 'State',
                        value: widget.businessEntity.stateValue!,
                      ),
                      CustomSpacers.height10,
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.businessEntity.districtValue != null,
                  child: Column(
                    children: [
                      LabelValueWidget(
                        label: 'District',
                        value: widget.businessEntity.districtValue!,
                      ),
                      CustomSpacers.height10,
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.businessEntity.talukaValue != null,
                  child: Column(
                    children: [
                      LabelValueWidget(
                        label: 'Taluka',
                        value: widget.businessEntity.talukaValue!,
                      ),
                      CustomSpacers.height10,
                    ],
                  ),
                ),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'Reg. Address',
                    value: widget.businessEntity.registeredAddress),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'PIN', value: widget.businessEntity.pinCode),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'Timing',
                    value:
                        '${widget.businessEntity.openingTime} - ${widget.businessEntity.closingTime}'),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'Category Level 1',
                    value: widget.businessEntity.categoryLevel1Value ?? ""),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'Category Level 2',
                    value: widget.businessEntity.categoryLevel2Value ?? ""),
                CustomSpacers.height10,
                LabelValueWidget(
                  label: 'Category Level 3',
                  value: (widget.businessEntity.categoryLevel3Value != null &&
                          widget.businessEntity.categoryLevel3Value!.isNotEmpty)
                      ? widget.businessEntity.categoryLevel3Value!
                          .map((e) => e)
                          .join(", ")
                      : "",
                ),
                CustomSpacers.height20,
                ImagePreviewWidget(
                  secondaryImages: widget.businessEntity.secondaryImages,
                  primaryImage: widget.businessEntity.primaryImage,
                  isNetworkImages: widget.businessEntity.isNeworkImages,
                ),
                CustomSpacers.height20,
                Row(
                  children: [
                    _buildIconText(
                        icon: Icons.star,
                        text: widget.businessEntity.rating != null
                            ? widget.businessEntity.rating.toString()
                            : '0',
                        context: context),
                    CustomSpacers.width10,
                    _buildIconText(
                        icon: Icons.share,
                        text: widget.businessEntity.shareCount != null
                            ? widget.businessEntity.shareCount.toString()
                            : '0',
                        context: context),
                  ],
                ),
                CustomSpacers.height10,
                CustomSpacers.height56,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconText(
      {required String text,
      required IconData icon,
      required BuildContext context}) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorPalette.textDark,
          size: 13,
        ),
        CustomSpacers.width10,
        Text(
          text,
          style: AppTextThemes.theme(context).bodyMedium,
        ),
      ],
    );
  }
}
