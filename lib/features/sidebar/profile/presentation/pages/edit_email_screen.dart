import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditEmailScreen extends StatefulWidget {
  const EditEmailScreen({super.key});

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  final _phoneTc = TextEditingController();
  final _emailTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "EDIT PROFILE",
      height: MediaQuery.of(context).size.height,
      enableMenu: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: _emailTc,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                    ),
                    CustomSpacers.height16,
                    CustomButton(
                      btnText: "Get OTP",
                      height: 50,
                      width: double.infinity,
                      onPressed: () {},
                    ),
                    CustomSpacers.height30,
                    CustomTextField(
                      controller: _phoneTc,
                      keyboardType: TextInputType.phone,
                      hintText: "Phone Number",
                      maxLength: 10,
                    ),
                    CustomSpacers.height16,
                    CustomButton(
                      btnText: "Get Verification Link",
                      height: 50,
                      width: double.infinity,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
