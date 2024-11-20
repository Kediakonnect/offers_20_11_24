import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPreferencesScreen extends StatefulWidget {
  const EditPreferencesScreen({super.key});

  @override
  State<EditPreferencesScreen> createState() => _EditPreferencesScreenState();
}

class _EditPreferencesScreenState extends State<EditPreferencesScreen> {
  final _langTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "EDIT PREFERENCES",
      height: MediaQuery.of(context).size.height,
      enableMenu: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
        child: Column(
          children: [
            CustomDropDown(
              hintText: "Select Language",
              options: const ["English", "Hindi"],
              controller: _langTc,
              width: double.infinity,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your language';
                }
                return null;
              },
            ),
            CustomSpacers.height20,
            CustomButton(
              onPressed: () {},
              btnText: "Update",
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
