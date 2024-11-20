import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_chip.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;
  final Color? color;
  const NewsCard({super.key, required this.onTap, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeuroMorphicContainer(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null && color != null)
              CustomChip(color: color!, text: label!),
            CustomSpacers.height10,
            RoundedImage.network(
              width: 130,
              height: 140,
              imagePath: sampleNews,
            ),
            CustomSpacers.height10,
            Text(
              'The Time of India',
              style: AppTextThemes.theme(context).headlineLarge,
            ),
            CustomSpacers.height10,
            Text(
              '13-12-2023',
              style: AppTextThemes.theme(context).bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

String sampleNews =
    'https://s3-alpha-sig.figma.com/img/b5d1/fd6d/d8c9f1c80e2d8f1fd64a90a4a7d1c27f?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VuJPv1gU4ZRjWVFISCALXfHrAWintff3S6R9LJXTEvJ-q6jhSR3KoQnNRyCpsd8j3lbP6OZmtWr6u19KpSPV-nFQWG4hetCkd-6Coyqx7cnQY8GxSp6wF1nAchiOXm0AshdAnupKZOY8CiC5vaq6HK14ua9Y1yXy6iLs9t7GKJHCLD2HZxpYybRIaV9AhX9SvgVC~ldgyTVGHhVqdCNa5RENA9h3g2PG6vuK9JoCFlE0250QYyfIFvZ43n4KcExvI6O74lA1vsrhEMQSUeNycJ8JtGqWF1VR457RcCo0gLYxWwscnkiDy8Njt01R943VJRA-4tQmo9JCRo3ELSqTGw__';
