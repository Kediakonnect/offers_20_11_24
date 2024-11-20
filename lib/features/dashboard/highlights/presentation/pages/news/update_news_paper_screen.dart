import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/news_viewer_card.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';

class UpdateNewsPaperScreen extends StatefulWidget {
  const UpdateNewsPaperScreen({super.key});

  @override
  State<UpdateNewsPaperScreen> createState() => _UpdateNewsPaperScreenState();
}

class _UpdateNewsPaperScreenState extends State<UpdateNewsPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Update Newspapers'.toUpperCase(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSpacers.height20,
            for (int i = 0; i < 2; i++) ...[
              NewsViewerCard(
                onTap: () {},
                pageNo: 'Page $i',
              ),
              CustomSpacers.height20,
            ],
            CustomSpacers.height20,
            CustomButton(
              onPressed: () {},
              btnText: 'Add another page',
              backgroundColor: ColorPalette.scaffoldBackgroundColor,
              textColor: ColorPalette.textDark,
              width: 160,
            ),
            CustomSpacers.height30,
            CustomButton(onPressed: () {}, btnText: 'Submit Issue')
          ],
        ),
      ),
    );
  }
}
