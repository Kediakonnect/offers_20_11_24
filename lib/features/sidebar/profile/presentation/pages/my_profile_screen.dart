import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/widget/profile_container.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/widget/social_media_icons_widget.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.end,
              style: AppTextThemes.lightTextTheme.bodyLarge,
            ),
          ),
          CustomSpacers.width8,
          Expanded(
            child: Text(
              value,
              style: AppTextThemes.lightTextTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "MY PROFILE",
      enableMenu: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Column(
          children: [
            // User Card
            ProfileContainer(
              title: "User Card",
              child: Column(
                children: [
                  CustomSpacers.height14,
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppIcons.divyamExcel,
                          width: 158.w,
                        ),
                        CustomSpacers.height12,
                        Image.network(AppImages.invitation),
                        CustomSpacers.height12,
                        QrImageView(
                          data:
                              "tel:+1234567890", // Replace with the phone number you want
                          version: QrVersions.auto,
                          size: 100.0,
                        ),
                        CustomSpacers.height10,
                        Text(
                          "Dr Arvind Suradkar",
                          textAlign: TextAlign.center,
                          style: AppTextThemes.lightTextTheme.displayLarge,
                        ),
                        CustomSpacers.height10,
                        Text(
                          "9028299771",
                          textAlign: TextAlign.center,
                          style: AppTextThemes.lightTextTheme.titleLarge,
                        ),
                        CustomSpacers.height10,
                        Text(
                          "Join me on Divyam Excel",
                          textAlign: TextAlign.center,
                          style:
                              AppTextThemes.lightTextTheme.titleLarge!.copyWith(
                            color: ColorPalette.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSpacers.height14,
                  const SocialMediaIconsWidget()
                ],
              ),
            ),
            CustomSpacers.height20,
            // Password
            ProfileContainer(
              title: "Password",
              onTap: () {
                CustomNavigator.pushTo(context, AppRouter.changePassword);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Password",
                    style: AppTextThemes.lightTextTheme.bodyLarge,
                  ),
                  CustomSpacers.width10,
                  Text(
                    "*********",
                    style: AppTextThemes.lightTextTheme.titleLarge,
                  )
                ],
              ),
            ),
            CustomSpacers.height20,
            // Basic Details
            ProfileContainer(
              title: "Basic Details",
              onTap: () {
                CustomNavigator.pushTo(context, AppRouter.basicDetails);
              },
              child: Column(
                children: [
                  _buildProfileDetail("First name", "Arvind"),
                  _buildProfileDetail("Last name", "Surakar"),
                  _buildProfileDetail("Date of birth", "10-12-1980"),
                  _buildProfileDetail("Sex", "Male"),
                  _buildProfileDetail("State", "Maharashtra"),
                  _buildProfileDetail('District', 'Buldhana'),
                  _buildProfileDetail('Taluka', 'Khamgaon'),
                  _buildProfileDetail('PIN code', '444303'),
                  _buildProfileDetail('Primary mobile', '9876543210'),
                  _buildProfileDetail('Secondary mobile', '9422323875'),
                  _buildProfileDetail('Email address', 'r.yashodhan@gmail.com'),
                  _buildProfileDetail('Referral code', 'JSFK280001'),
                ],
              ),
            ),

            CustomSpacers.height20,
            // Preferences
            ProfileContainer(
              title: "Preferences",
              onTap: () {
                CustomNavigator.pushTo(context, AppRouter.preferences);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Language",
                    style: AppTextThemes.lightTextTheme.bodyLarge,
                  ),
                  CustomSpacers.width10,
                  Text(
                    "Marathi",
                    style: AppTextThemes.lightTextTheme.titleLarge,
                  )
                ],
              ),
            ),

            CustomSpacers.height20,
            // MLM Details
            ProfileContainer(
              title: "MLM Details",
              onTap: () {
                CustomNavigator.pushTo(context, AppRouter.mlmDetails);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.yellow,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 25.w),
                    child: Text(
                      "Verification pending",
                      style: AppTextThemes.lightTextTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildProfileDetail("User ID", "FKU300002"),
                  _buildProfileDetail("Aadhar number", "3333 3333 3333"),
                  _buildProfileDetail("WhatsApp link",
                      "https://faq.whatsapp.com/3242937609289432/?cms_platform=web")
                ],
              ),
            ),

            CustomSpacers.height20,

            // Bank Details
            ProfileContainer(
              title: "Bank Details",
              onTap: () {
                CustomNavigator.pushTo(context, AppRouter.bankDetails);
              },
              child: Column(
                children: [
                  _buildProfileDetail('PAN number', 'AFZPK7190K'),
                  _buildProfileDetail('Bank a/c name', 'Arvind Suradkar'),
                  _buildProfileDetail('Bank a/c number', '31969292728'),
                  _buildProfileDetail('IFS code', 'SBIN0003282'),
                ],
              ),
            ),
            CustomSpacers.height10,
            // Around me
            ProfileContainer(
              title: "Around Me Lists",
              onTap: () {},
              child: Column(
                children: [
                  CustomSpacers.height20,
                  CustomCheckBoxTile(
                    onChanged: (option) {},
                    option: "Show me as ad designer",
                  ),
                  CustomSpacers.height20,
                  CustomCheckBoxTile(
                    onChanged: (option) {},
                    option: "Show me as blood donor",
                  ),
                  CustomSpacers.height20,
                  CustomCheckBoxTile(
                    onChanged: (option) {},
                    option: "Show me as snake catcher",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
