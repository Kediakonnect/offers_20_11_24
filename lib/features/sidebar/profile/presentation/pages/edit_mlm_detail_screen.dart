import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditMlmDetailScreen extends StatefulWidget {
  const EditMlmDetailScreen({super.key});

  @override
  State<EditMlmDetailScreen> createState() => EditMlmDetailScreenState();
}

class EditMlmDetailScreenState extends State<EditMlmDetailScreen> {
  final _aadharTc = TextEditingController();
  final _whatsAppGroup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "EDIT MLM DETAILS",
      enableMenu: true,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: "AADHAAR card number",
                    hintText: "3333 3333 3333",
                    controller: _aadharTc,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: "WhatsApp Group",
                    controller: _whatsAppGroup,
                    labelText: "WhatsApp group link",
                  ),
                  CustomSpacers.height20,
                  CustomButton(
                    onPressed: () {},
                    btnText: "Update",
                    width: double.infinity,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
