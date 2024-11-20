import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/profile_picture_selector.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBankDetailsScreen extends StatefulWidget {
  const EditBankDetailsScreen({super.key});

  @override
  State<EditBankDetailsScreen> createState() => _EditBankDetailsScreenState();
}

class _EditBankDetailsScreenState extends State<EditBankDetailsScreen> {
  final _panNumberTc = TextEditingController();
  final _nameTc = TextEditingController();
  final _passwordTc = TextEditingController();
  final _accountNumberTc = TextEditingController();
  final _ifscCodeTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      height: MediaQuery.of(context).size.height,
      appBarTitle: "EDIT BANK DETAILS",
      enableMenu: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 24.h),
        child: Column(
          children: [
            CustomTextField(
              labelText: "PAN card number",
              hintText: "PAN card number",
              controller: _panNumberTc,
            ),
            CustomSpacers.height20,
            ProfilePicViewerOrSelectorWidget(
              onChanged: (file) {},
              label: 'Upload Pan Image ',
              changeImageText: 'Change Pan Image',
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: "Full Name",
              controller: _nameTc,
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: "Password",
              controller: _passwordTc,
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: "Account Number",
              controller: _accountNumberTc,
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: "IFSC Code",
              controller: _ifscCodeTc,
            ),
            CustomSpacers.height20,
            CustomButton(
              btnText: "Update",
              width: double.infinity,
              height: 50,
              onPressed: () {},
            ),
            CustomSpacers.height30,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note:",
                  style: AppTextThemes.lightTextTheme.displayMedium,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Once submitted, this information will be verified.\n\nNo payment will be given until the verification is completed or if the information is wrong.\n\nYou can edit this information from your profile.",
                  style: AppTextThemes.lightTextTheme.bodyLarge!.copyWith(
                    color: ColorPalette.textDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
