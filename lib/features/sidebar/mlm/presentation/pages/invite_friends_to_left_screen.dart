import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';

class InviteFriendsToLeftScreen extends StatelessWidget {
  const InviteFriendsToLeftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'Invite Friends to Left'.toUpperCase(),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
