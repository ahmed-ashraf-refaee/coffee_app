import 'package:flutter/material.dart';

import 'widgets/change_email_view_body.dart';

class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ChangeEmailViewBody()));
  }
}
