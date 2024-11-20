import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class BusinessEntity {
  final String name;
  final String mobile;
  final String email;
  final String contactPerson;
  final String websiteUrl;
  final String? whatsappNumber;
  final String state;
  final String metroCity;
  final String district;
  final String taluka;
  final String? stateValue;
  final String? districtValue;
  final String? talukaValue;
  final String registeredAddress;
  final String pinCode;
  final String googleMapLink;
  final String openingTime;
  final String closingTime;
  final String? categoryLevel1;
  final String? categoryLevel2;
  final List<String>? categoryLevel3;
  final String? categoryLevel1Value;
  final String? categoryLevel2Value;
  final List<String>? categoryLevel3Value;
  final List<String> secondaryImages;
  final String primaryImage;
  final String? logoImage; // Changed to nullable
  final bool? isNeworkImages;
  final String? businessId;
  final String? method;
  final bool? isVerified;
  String? categoryName;
  final double? rating;
  final int? shareCount;
  final bool? isFavourite;
  final List<Offer>? offers;
  final String? stateName, districtName, talukaName;

  BusinessEntity({
    required this.name,
    required this.mobile,
    required this.email,
    required this.contactPerson,
    this.stateName,
    this.districtName,
    this.talukaName,
    this.categoryName,
    required this.websiteUrl,
    this.categoryLevel1Value,
    this.categoryLevel2Value,
    this.categoryLevel3Value,
    required this.whatsappNumber,
    required this.state,
    required this.metroCity,
    required this.district,
    required this.taluka,
    this.stateValue,
    this.districtValue,
    this.talukaValue,
    required this.registeredAddress,
    required this.pinCode,
    required this.googleMapLink,
    required this.openingTime,
    required this.closingTime,
    this.categoryLevel1,
    this.categoryLevel2,
    this.categoryLevel3,
    required this.secondaryImages,
    required this.primaryImage,
    this.logoImage, // Updated constructor to accept nullable logoImage
    this.isNeworkImages = false,
    this.businessId,
    this.isVerified,
    this.method,
    this.rating,
    this.shareCount,
    this.isFavourite,
    this.offers,
  });

  BusinessEntity copyWith({
    String? name,
    String? categoryName,
    String? mobile,
    String? email,
    String? contactPerson,
    String? websiteUrl,
    String? whatsappNumber,
    String? state,
    String? metroCity,
    String? district,
    String? taluka,
    String? registeredAddress,
    String? pinCode,
    String? googleMapLink,
    String? openingTime,
    String? closingTime,
    String? categoryLevel1,
    String? categoryLevel2,
    List<String>? secondaryImages,
    String? primaryImage,
    String? logoImage, // Updated copyWith method
    bool? isNeworkImages,
    List<String>? categoryLevel3,
    String? businessId,
    String? method,
    double? rating,
    int? shareCount,
    bool? isVerified,
    bool? isFavourite,
  }) {
    return BusinessEntity(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      state: state ?? this.state,
      metroCity: metroCity ?? this.metroCity,
      district: district ?? this.district,
      taluka: taluka ?? this.taluka,
      registeredAddress: registeredAddress ?? this.registeredAddress,
      pinCode: pinCode ?? this.pinCode,
      googleMapLink: googleMapLink ?? this.googleMapLink,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      categoryLevel1: categoryLevel1 ?? this.categoryLevel1,
      categoryLevel2: categoryLevel2 ?? this.categoryLevel2,
      secondaryImages: secondaryImages ?? this.secondaryImages,
      primaryImage: primaryImage ?? this.primaryImage,
      logoImage: logoImage ?? this.logoImage,
      businessId: businessId ?? this.businessId,
      isNeworkImages: isNeworkImages ?? this.isNeworkImages,
      categoryLevel3: categoryLevel3 ?? this.categoryLevel3,
      method: method ?? this.method,
      categoryName: categoryName ?? this.categoryName,
      isVerified: isVerified ?? isVerified,
      rating: rating ?? this.rating,
      shareCount: shareCount ?? this.shareCount,
      stateName: stateName,
      districtName: districtName,
      talukaName: talukaName,
      isFavourite: isFavourite,
    );
  }

  factory BusinessEntity.toEmpty() {
    return BusinessEntity(
      name: '',
      mobile: '',
      email: '',
      contactPerson: '',
      websiteUrl: '',
      whatsappNumber: '',
      state: '',
      metroCity: '',
      district: '',
      taluka: '',
      registeredAddress: '',
      pinCode: '',
      googleMapLink: '',
      openingTime: '',
      closingTime: '',
      categoryLevel1: '',
      categoryLevel2: '',
      secondaryImages: [],
      primaryImage: '',
      categoryLevel3: [],
      logoImage: null, // Set default to null
    );
  }

  Future<FormData> toFormData() async {
    List<MultipartFile> secondaryImagesMultipart = [];

    // Handle secondary images, both URL and local
    for (var image in secondaryImages) {
      if (image.startsWith('http')) {
        // Download image from URL
        File downloadedImage =
            await _downloadFile(image, _getAbsolutePath(image));
        secondaryImagesMultipart.add(
          await MultipartFile.fromFile(
            downloadedImage.path,
            filename: _getAbsolutePath(image),
          ),
        );
      } else {
        secondaryImagesMultipart.add(
          await MultipartFile.fromFile(
            image,
            filename: _getAbsolutePath(image),
          ),
        );
      }
    }

    // Handle logo image, download if URL and only if not null
    MultipartFile? logoMultipartFile;
    if (logoImage != null && logoImage!.isNotEmpty) {
      if (logoImage!.startsWith('http')) {
        File downloadedLogo =
            await _downloadFile(logoImage!, _getAbsolutePath(logoImage!));
        if (await downloadedLogo.exists()) {
          logoMultipartFile = await MultipartFile.fromFile(
            downloadedLogo.path,
            filename: _getAbsolutePath(logoImage!),
          );
        } else {
          throw Exception("Downloaded logo file does not exist.");
        }
      } else {
        File localLogo = File(logoImage!);
        if (await localLogo.exists()) {
          logoMultipartFile = await MultipartFile.fromFile(
            logoImage!,
            filename: _getAbsolutePath(logoImage!),
          );
        } else {
          throw Exception("Local logo file does not exist at path: $logoImage");
        }
      }
    }

    // Handle primary image, download if URL
    MultipartFile primaryImageMultipartFile;
    if (primaryImage.startsWith('http')) {
      File downloadedPrimaryImage =
          await _downloadFile(primaryImage, _getAbsolutePath(primaryImage));
      primaryImageMultipartFile = await MultipartFile.fromFile(
        downloadedPrimaryImage.path,
        filename: _getAbsolutePath(primaryImage),
      );
    } else {
      primaryImageMultipartFile = await MultipartFile.fromFile(
        primaryImage,
        filename: _getAbsolutePath(primaryImage),
      );
    }

    // Create FormData object
    final Map<String, dynamic> formDataMap = {
      'name': name,
      'mobile': mobile,
      'email': email,
      'contact_person': contactPerson,
      'website_url': websiteUrl,
      'whatsapp_number': whatsappNumber,
      'state': state,
      'metro_city': metroCity,
      'district': district,
      'taluka': taluka,
      'registered_address': registeredAddress,
      'pin_code': pinCode,
      'google_map_link': googleMapLink,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'primary_image': primaryImageMultipartFile,
      'category_level_1': categoryLevel1,
      'category_level_2': categoryLevel2,
      'category_level_3': jsonEncode(categoryLevel3),
      '_method': method,
    };

    formDataMap['logo_image'] = logoMultipartFile;

    for (int i = 0; i < secondaryImagesMultipart.length; i++) {
      formDataMap['secondary_images[$i]'] = secondaryImagesMultipart[i];
    }

    final formData = FormData.fromMap(formDataMap);

    debugPrint("FormData: ${formData.fields}");
    return formData;
  }
}

String formatTime(String time) {
  final timeParts = time.split(':');
  if (timeParts.length != 2) return time; // If invalid format, return as is

  // Ensure time is in 24-hour format with two digits for hours and minutes
  final hours = int.parse(timeParts[0]).toString().padLeft(2, '0');
  final minutes = int.parse(timeParts[1]).toString().padLeft(2, '0');
  return '$hours:$minutes';
}

// Helper method to download a file from a URL
Future<File> _downloadFile(String url, String fileName) async {
  try {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName';

    await Dio().download(url, filePath);
    return File(filePath); // Return the downloaded file
  } catch (e) {
    debugPrint('Error downloading file: $e');
    rethrow;
  }
}

// Helper method to extract the file name from the path or URL
String _getAbsolutePath(String filePath) {
  int lastSeparatorIndex = filePath.lastIndexOf('/');
  return filePath.substring(lastSeparatorIndex + 1);
}
