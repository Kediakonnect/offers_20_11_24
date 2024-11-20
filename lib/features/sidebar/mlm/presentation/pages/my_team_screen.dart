import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/outlined_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_text.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  List<String> names = [
    "Abhishek Deshpande",
    "Snehalata Kulkarni",
    "Swapnil Patil",
    "Anushree Gadgil",
    "Rohan Desai",
    "Shubham Thorat",
    "Anjali Phadnis",
    "Pratiksha Salunke",
    "Shashwat Dharangaonkar",
    "Arvind Suradkar",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'My Team'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: FigmaValueConstants.defaultPaddingH.w,
        ),
        child: Column(
          children: [
            CustomSpacers.height20,
            Text(
              'Click on the buttons below to join WhatsApp groups of your uplone',
              style: AppTextThemes.theme(context).bodyLarge,
            ),
            CustomSpacers.height20,
            ...names.map((e) => _buildWhatsAppTile(e)),
            CustomSpacers.height30,
            _buildDivider(),
            CustomSpacers.height30,
            const NeuroMorphicText(
              text: 'Enter Your WhatsApp Group Link',
            ),
            CustomSpacers.height30,
            _buildDivider(),
            CustomSpacers.height30,
            const NeuroMorphicText(
              text: 'Create event for your network',
            ),
            const Text('You have 5000 members in your downline'),
            CustomSpacers.height30,
            _buildDivider(),
            CustomSpacers.height30,
            OutlinedContainer(
              padding: const EdgeInsets.fromLTRB(
                10,
                20,
                10,
                10,
              ),
              child: Column(
                children: [
                  Text(
                    'Upline User IDs',
                    style: AppTextThemes.theme(context).headlineLarge,
                  ),
                  CustomSpacers.height10,
                  for (int i = 0; i < 5; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lucas Thompson',
                            style: AppTextThemes.theme(context).bodyLarge),
                        Text('EJK1991002',
                            style: AppTextThemes.theme(context).bodyLarge),
                      ],
                    ),
                    CustomSpacers.height10,
                  ]
                ],
              ),
            ),
            CustomSpacers.height30,
            Text(
              'Downline Tree',
              style: AppTextThemes.theme(context).displayLarge,
            ),
            CustomSpacers.height30,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return NeuroMorphicContainer(
      height: 2,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildWhatsAppTile(String name) {
    return Column(
      children: [
        NeuroMorphicContainer(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.whatsAppColored,
                height: 20.h,
                width: 20.w,
              ),
              CustomSpacers.width10,
              Text(name, style: AppTextThemes.theme(context).bodyLarge),
            ],
          ),
        ),
        CustomSpacers.height10,
      ],
    );
  }
}
