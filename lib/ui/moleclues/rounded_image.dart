import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/atoms/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedImage extends StatelessWidget {
  final double? height, width;
  final String imagePath;
  final bool isFile;
  final bool isNetwork;
  final bool isAsset;

  const RoundedImage.file({
    super.key,
    this.height,
    this.width,
    required this.imagePath,
    this.isFile = true,
    this.isNetwork = false,
    this.isAsset = false,
  });
  const RoundedImage.network({
    super.key,
    this.height,
    this.width,
    required this.imagePath,
    this.isFile = false,
    this.isNetwork = true,
    this.isAsset = false,
  });
  const RoundedImage.asset({
    super.key,
    this.height,
    this.width,
    required this.imagePath,
    this.isFile = false,
    this.isNetwork = false,
    this.isAsset = true,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return Container(
        width: width?.h,
        height: height?.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: ColorPalette.red,
              ),
              CustomSpacers.height10,
              const Text('Image not found'),
            ],
          ),
        ),
      );
    }
    if (isAsset) {
      return _buildAsset(imagePath);
    } else if (isFile) {
      return _buildFile(imagePath);
    } else {
      return _buildNetworkImage(imagePath);
    }
  }

  Widget _buildFile(String path) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 700.h,
      ),
      width: width?.h,
      height: height?.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(File(path), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildAsset(String path) {
    return Container(
      width: width?.h,
      height: height?.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(path, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNetworkImage(String path) {
    return CachedNetworkImage(
      imageUrl: path,
      imageBuilder: (context, imageProvider) => Container(
        constraints: BoxConstraints(
          maxHeight: 700.h,
        ),
        width: width?.w,
        height: height?.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => height == null || width == null
          ? const Loading()
          : ShimmerContainer(
              height: height!.h - 10,
              width: width!.w - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
