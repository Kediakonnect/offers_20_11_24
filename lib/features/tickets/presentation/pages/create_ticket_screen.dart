import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/attach_or_review_image_widget.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/profile_picture_selector.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_entity.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_screen_entity.dart';
import 'package:divyam_flutter/features/tickets/presentation/cubit/ticket_cubit.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> contentViolations = [
  "Copyright Infringement",
  "Privacy Violation",
  "Hate Speech / Harassment",
  "National Security / Anti-National - Sedition",
  "False and Misleading / Misrepresentation",
  "Illegal Activities",
  "Lack of Consent",
  "Inappropriate / Sexual / Pornography",
  "Anti-Social / Insult to Religious Sentiments / Religious Offense"
];

class CreateTicketScreen extends StatefulWidget {
  final CreateTicketScreenEntity entity;
  const CreateTicketScreen({super.key, required this.entity});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  late TicketCubit _ticketCubit;
  final _formKey = GlobalKey<FormState>();
  final _departmentTc = TextEditingController();
  final _titletc = TextEditingController();
  final _descriptionTc = TextEditingController();

  @override
  void initState() {
    _ticketCubit = sl<TicketCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "OPEN NEW TICKET",
      body: BlocConsumer<TicketCubit, TicketState>(
        bloc: _ticketCubit,
        listener: (context, state) {
          if (state is CreateTicketSuccess) {
            _formKey.currentState?.reset();
            ScaffoldHelper.showSuccessSnackBar(
              context: context,
              message: "Report Successfully Submitted",
            );

            Navigator.pop(context);
          }

          if (state is CreateTicketError) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.errorMessage);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDropDown(
                    options: contentViolations,
                    controller: _departmentTc,
                    hintText: "Select Department",
                    validator: (value) =>
                        value == null ? "Please select your department" : null,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: "What's your issue about",
                    controller: _titletc,
                    validator: (value) => value == null || value.isEmpty
                        ? "Title is required"
                        : null,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: "Details of your issue",
                    controller: _descriptionTc,
                    validator: (value) => value == null || value.isEmpty
                        ? "Description is required"
                        : null,
                  ),
                  CustomSpacers.height20,
                  CustomButton(
                      isLoading: state is CreateTicketLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _ticketCubit.createTicket(
                            entity: CreateTicketEntity(
                              department: _departmentTc.text,
                              title: _titletc.text,
                              description: _descriptionTc.text,
                              itemId: widget.entity.itemId,
                            ),
                          );
                        }
                      },
                      btnText: "Open Ticket")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
