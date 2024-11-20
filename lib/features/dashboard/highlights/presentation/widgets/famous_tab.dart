import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/famous_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FamousTab extends StatelessWidget {
  const FamousTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSpacers.height10,
        const FamousCard(
          imagePath: '',
        ),
        CustomSpacers.height20,
        const FamousCard(),
        CustomSpacers.height120,
      ],
    );
  }
}
