import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdDesignerScreen extends StatefulWidget {
  const AdDesignerScreen({super.key});

  @override
  State<AdDesignerScreen> createState() => AdDesignerScreenState();
}

class AdDesignerScreenState extends State<AdDesignerScreen> {
  final _fullNameTc = TextEditingController();
  final _selectMobileTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "AD DESIGNER",
      enableMenu: true,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    hintText: "Vaibhav Phatak",
                    controller: _fullNameTc,
                  ),
                  CustomSpacers.height20,
                  CustomDropDown(
                    options: const [],
                    hintText: "Select Mobile",
                    controller: _selectMobileTc,
                  ),
                  CustomSpacers.height20,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Location: ",
                          style: AppTextThemes.lightTextTheme.displayMedium,
                        ),
                        TextSpan(
                          text: "Khamgaon / Buldhana",
                          style: AppTextThemes.lightTextTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                  CustomSpacers.height20,
                  CustomButton(
                    onPressed: () {},
                    btnText: "Register as Ad Designer",
                    width: double.infinity,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
