import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/rate_business_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class BusinessRatingModal extends StatefulWidget {
  final BusinessEntity? businessEntity;
  final Function(RateBusinessEntity entity) onConfirmTap;
  const BusinessRatingModal(
      {super.key, this.businessEntity, required this.onConfirmTap});

  @override
  _RatingModalState createState() => _RatingModalState();
}

class _RatingModalState extends State<BusinessRatingModal> {
  int _rating = 0;

  Widget _buildStar(int index) {
    if (index < _rating) {
      return IconButton(
        onPressed: () {
          setState(() {
            _rating = index + 1;
          });
        },
        icon: const Icon(Icons.star, color: Colors.amber, size: 40),
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            _rating = index + 1;
          });
        },
        icon: const Icon(Icons.star_border, color: Colors.grey, size: 40),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Rate Us',
        style: AppTextThemes.theme(context).bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Please rate this Business:'),
          CustomSpacers.height16,
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                  color: ColorPalette.textDark,
                ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirmTap(
              RateBusinessEntity(
                businessId: widget.businessEntity?.businessId ?? "",
                rating: _rating.toString(),
              ),
            );
          },
          child: const Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
