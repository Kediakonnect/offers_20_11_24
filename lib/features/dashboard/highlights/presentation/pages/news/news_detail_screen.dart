import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.75),
              Colors.black.withOpacity(0.75),
            ],
            stops: [0.0, 0.6302, 1.0], // Corresponding stops for the gradient
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.turn_left,
                color: ColorPalette.scaffoldBackgroundColor),
            SvgPicture.asset(
              AppIcons.share,
              color: ColorPalette.scaffoldBackgroundColor,
            ),
            Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: ColorPalette.scaffoldBackgroundColor,
                ),
                CustomSpacers.width10,
                const Icon(Icons.arrow_forward_ios,
                    color: ColorPalette.scaffoldBackgroundColor),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              panEnabled: false, // Set it to false
              // boundaryMargin: EdgeInsets.all(100),
              minScale: 0.1,
              maxScale: 4,
              child: Image.network(
                'https://s3-alpha-sig.figma.com/img/702f/9d74/4ad23d2aecf0f06335e6180f4f6c47ba?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qv26JG7JW~EtMcI7cEVeeeB08NQtEl8O6Lr6l8meDf90b7L3CxgxeOdy4bQmyzbPzZ17scHC8PoNFfUn3i77ZLHqtpQ9zixzI~i7gp3SF7oNpGjw-WvbksatMpoVRmqqkC41QUE4kBkv8NKiHW5qczxdagKVaWGTsGlDtwJegaZg712eqZLu-cLpEyvvckiKrPj5G0t3Ya4Qy04eD-~3yN6bTMLBjnKLckMG5kPg5s4azCLCe3yTWg3kTH2oxq2UVipzbuCC~cx9FUnei2RH-jS1uXF6psoG55RMKrys2EbvRsLD~8ODsXF60Mh8ktl-Ae76e~8MKj2MgMtHTf8N0Q__',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: MediaQuery.of(context).viewPadding,
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.75),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.6302,
                    1.0
                  ], // Corresponding stops for the gradient
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Image.asset(
                    AppIcons.appLogo2,
                    height: 25.h,
                  ),
                  const Spacer(),
                  SvgPicture.asset(AppIcons.moreRounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
