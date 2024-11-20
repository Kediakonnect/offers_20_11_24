import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';

class NewsViewerCard extends StatelessWidget {
  final String pageNo;
  final double? height, width;
  final VoidCallback onTap;
  const NewsViewerCard(
      {super.key,
      required this.onTap,
      required this.pageNo,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeuroMorphicContainer(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedImage.network(
                height: height ?? 155,
                width: width ?? 130,
                imagePath:
                    'https://s3-alpha-sig.figma.com/img/702f/9d74/4ad23d2aecf0f06335e6180f4f6c47ba?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qv26JG7JW~EtMcI7cEVeeeB08NQtEl8O6Lr6l8meDf90b7L3CxgxeOdy4bQmyzbPzZ17scHC8PoNFfUn3i77ZLHqtpQ9zixzI~i7gp3SF7oNpGjw-WvbksatMpoVRmqqkC41QUE4kBkv8NKiHW5qczxdagKVaWGTsGlDtwJegaZg712eqZLu-cLpEyvvckiKrPj5G0t3Ya4Qy04eD-~3yN6bTMLBjnKLckMG5kPg5s4azCLCe3yTWg3kTH2oxq2UVipzbuCC~cx9FUnei2RH-jS1uXF6psoG55RMKrys2EbvRsLD~8ODsXF60Mh8ktl-Ae76e~8MKj2MgMtHTf8N0Q__',
              ),
              CustomSpacers.height10,
              Text(pageNo, style: AppTextThemes.theme(context).bodyLarge),
            ],
          )),
    );
  }
}
