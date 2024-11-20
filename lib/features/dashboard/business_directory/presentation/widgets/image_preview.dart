import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final List<String> secondaryImages;
  final String primaryImage;
  final bool? isNetworkImages;
  const ImagePreviewWidget(
      {super.key,
      required this.secondaryImages,
      required this.primaryImage,
      this.isNetworkImages = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNetworkImages!)
          RoundedImage.network(
            height: 280,
            width: double.maxFinite,
            imagePath: primaryImage,
          ),
        if (!isNetworkImages!)
          RoundedImage.file(
            height: 280,
            width: double.maxFinite,
            imagePath: primaryImage,
          ),
        CustomSpacers.height10,
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
            childAspectRatio:
                1.0, // Aspect ratio of each grid item (width / height)
          ),
          itemCount: secondaryImages.length, // Number of items in the grid
          itemBuilder: (context, index) {
            if (isNetworkImages!) {
              return RoundedImage.network(
                height: 150,
                width: 150,
                imagePath: secondaryImages[index],
              );
            } else {
              return RoundedImage.file(
                height: 150,
                width: 150,
                imagePath: secondaryImages[index],
              );
            }
          },
        ),
      ],
    );
  }
}
