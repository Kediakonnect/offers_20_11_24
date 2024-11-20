import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/language_enums.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_form_validators.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OffersLanguageForm extends StatefulWidget {
  final List<OfferTitleEntity>? offerTitle;
  final Function(List<OfferTitleEntity>) onLanguagesChanged;
  const OffersLanguageForm({
    super.key,
    this.offerTitle,
    required this.onLanguagesChanged,
  });

  @override
  State<OffersLanguageForm> createState() => _OffersLanguageFormState();
}

class _OffersLanguageFormState extends State<OffersLanguageForm> {
  List<LanguageEntity> selectedlanguages = [
    LanguageEntity(
      language: LanguageEnums.english,
      title: TextEditingController(),
      description: TextEditingController(),
    ),
  ];

  List<OfferTitleEntity> offerTitle = [OfferTitleEntity.toEmpty()];

  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _descriptionControllers = [];

  @override
  void didUpdateWidget(covariant OffersLanguageForm oldWidget) {
    if (widget.offerTitle != oldWidget.offerTitle) {
      addLanguage();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    addLanguage();
  }

  void addLanguage() {
    if (widget.offerTitle != null && widget.offerTitle!.isNotEmpty) {
      selectedlanguages = [];

      offerTitle = widget.offerTitle ?? [OfferTitleEntity.toEmpty()];

      for (var i = 0; i < offerTitle.length; i++) {
        setState(() {
          selectedlanguages.add(
            LanguageEntity(
              title: TextEditingController(),
              description: TextEditingController(),
              language: offerTitle[i].language.languageEnums,
            ),
          );
          _titleControllers.add(TextEditingController());
          _titleControllers[i].text = offerTitle[i].title;
          _descriptionControllers.add(TextEditingController());
          _descriptionControllers[i].text = offerTitle[i].description;
        });
      }

      debugPrint(selectedlanguages.length.toString());
    } else {
      offerTitle = [OfferTitleEntity.toEmpty()];
      _titleControllers.add(TextEditingController());
      _descriptionControllers.add(TextEditingController());
      selectedlanguages = [
        LanguageEntity(
            language: LanguageEnums.english,
            title: TextEditingController(),
            description: TextEditingController()),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedlanguages.isNotEmpty) {
      return Column(
        children: [
          for (var i = 0; i < selectedlanguages.length; i++) ...[
            CustomDropDown(
              groupValue: selectedlanguages[i].language?.label,
              validator: (val) => OffersValidators.validateLanguage(val),
              options: LanguageEnums.values.map((e) => e.label).toList(),
              onChanged: (idx) {
                offerTitle[i] = offerTitle[i]
                    .copyWith(language: LanguageEnums.values[idx!].value);
                widget.onLanguagesChanged(offerTitle);
              },
              hintText: 'Language',
              controller: TextEditingController(),
            ),
            CustomSpacers.height20,
            CustomTextField(
              validator: (val) => OffersValidators.validateOfferTitle(
                  _titleControllers[i].text.isEmpty
                      ? null
                      : _titleControllers[i].text),
              hintText: 'Offer title',
              controller: _titleControllers[i],
              onChanged: (val) {
                offerTitle[i] = offerTitle[i].copyWith(title: val);
                widget.onLanguagesChanged(offerTitle);
              },
            ),
            CustomSpacers.height20,
            CustomTextField(
              validator: (val) => OffersValidators.validateOfferDescription(
                _descriptionControllers[i].text.isEmpty
                    ? null
                    : _descriptionControllers[i].text,
              ),
              maxLines: 6,
              onChanged: (value) {
                offerTitle[i] = offerTitle[i].copyWith(description: value);
                widget.onLanguagesChanged(offerTitle);
              },
              hintText: 'Offer description',
              controller: _descriptionControllers[i],
            ),
            CustomSpacers.height20,
          ],
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedlanguages.add(
                    LanguageEntity(
                      title: TextEditingController(),
                      description: TextEditingController(),
                    ),
                  );
                  _titleControllers.add(TextEditingController());
                  _descriptionControllers.add(TextEditingController());
                  offerTitle.add(OfferTitleEntity.toEmpty());
                });
              },
              child: Text(
                '+ Add more language',
                style: AppTextThemes.theme(context)
                    .bodySmall
                    ?.copyWith(color: ColorPalette.primaryColor),
              ),
            ),
          ),
        ],
      );
    } else {
      return Text(widget.offerTitle.toString());
    }
  }
}

class LanguageEntity extends Equatable {
  final LanguageEnums? language;
  final TextEditingController title, description;

  const LanguageEntity({
    this.language,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [language, title, description];
}
