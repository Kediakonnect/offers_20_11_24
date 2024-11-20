import 'dart:io';

import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/attach_or_review_image_widget.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/category_drop_downs.dart';
import 'package:flutter/material.dart';

class BusinessFormStepTwo extends StatefulWidget {
  final BusinessDirectoryCubit businessDirectoryCubit;
  const BusinessFormStepTwo({super.key, required this.businessDirectoryCubit});

  @override
  State<BusinessFormStepTwo> createState() => _BusinessFormStepTwoState();
}

class _BusinessFormStepTwoState extends State<BusinessFormStepTwo> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CategoriesDropDown(
          businessDirectoryCubit: widget.businessDirectoryCubit,
        ),
        CustomSpacers.height20,
        AttachOrReviewShopPicWidget(
          secondayImages: !widget.businessDirectoryCubit.formType.isAdd
              ? widget.businessDirectoryCubit.businessEntity.secondaryImages
              : null,
          primaryImage: !widget.businessDirectoryCubit.formType.isAdd
              ? widget.businessDirectoryCubit.businessEntity.primaryImage
              : '',
          onPrimaryImageChanged: (file) => file != null
              ? widget.businessDirectoryCubit
                  .primaryImageChanged(File(file.path))
              : null,
          onSecondaryImageChanged: (files) {
            if (files != null) {
              widget.businessDirectoryCubit.secondaryImagesChanged(
                  files.map((e) => File(e.path)).toList());
            }
          },
          onlyPickSecondaryImages: false,
          secondaryImageLabel: 'Select Secondary Images(max 2)',
          maxSecondaryImages: 2,
        ),
        CustomSpacers.height20,
      ],
    );
  }
}
