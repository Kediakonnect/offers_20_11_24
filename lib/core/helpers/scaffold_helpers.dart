import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/image_picking_options.dart';
import 'package:divyam_flutter/core/helpers/image_picker_helper.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScaffoldHelper {
  static void showSuccessSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorPalette.green,
      ),
    );
  }

  static void showFailureSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorPalette.red,
      ),
    );
  }

  static void infoSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 45, 127, 136),
      ),
    );
  }

  static Future<void> showBottomModelSheet({
    required BuildContext context,
    required Widget child,
    bool? isDismissible,
    bool? canPop,
    bool? isScrollControlled,
  }) async {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled ?? true,
      isDismissible: isDismissible ?? true,
      builder: (context) {
        return PopScope(
          canPop: canPop ?? true,
          child: Container(
            clipBehavior: Clip.none,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                16, 16, 16, MediaQuery.of(context).padding.bottom),
            child: Stack(
              children: [
                child,
                Positioned(
                  top: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      context: context,
    );
  }

  static Future<XFile?> pickImage(BuildContext context) async {
    ImagePickingOptions? selectedOption;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 21.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Image Source :',
                  style: Theme.of(context).textTheme.titleLarge),
              CustomSpacers.height20,
              for (var option in ImagePickingOptions.values) ...[
                GestureDetector(
                  onTap: () {
                    selectedOption = option;
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        option.icon,
                        color: ColorPalette.primaryColor,
                      ),
                      CustomSpacers.width12,
                      Text(
                        option.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                CustomSpacers.height20,
              ]
            ],
          ),
        );
      },
    );

    if (selectedOption != null) {
      if (selectedOption!.isCamera) {
        return await ImagePickerHelper.pickImageFromCamera();
      } else {
        return await ImagePickerHelper.pickImageFromGallery();
      }
    }

    return null;
  }
}
