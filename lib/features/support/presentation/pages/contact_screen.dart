import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/widget/social_media_icons_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _queryTc = TextEditingController();
  final _queryDetailsTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "CONTACT US",
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelValueWidget(
                  label: "Sales Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Network Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Event Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Offer Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Publication Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Famous Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Your Location Helpline",
                  value: "+91-1234567890",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Email",
                  value: "help@divyamexcel.com",
                ),
                CustomSpacers.height20,
                const LabelValueWidget(
                  label: "Website",
                  value: "www.divyamexcel.com",
                ),
              ],
            ),
            CustomSpacers.height30,
            const SocialMediaIconsWidget(),
            CustomSpacers.height30,
            Center(
              child: Text(
                "Read FAQs before you ask for help",
                style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                  color: ColorPalette.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            CustomSpacers.height30,
            CustomTextField(
              hintText: "Topic of your query",
              controller: _queryTc,
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: "Details of your query",
              controller: _queryDetailsTc,
              maxLines: 5,
            ),
            CustomSpacers.height20,
            CustomButton(
              onPressed: () {},
              btnText: "Submit Query",
            )
          ],
        ),
      ),
    );
  }
}
