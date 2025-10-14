import 'package:coffee_app/features/profile/presentation/view/edit_profile_view/widgets/change_pass_view_body.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ChangePasswordViewBody()));
  }
}
