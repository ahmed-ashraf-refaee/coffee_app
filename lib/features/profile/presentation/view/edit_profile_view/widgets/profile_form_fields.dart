import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../generated/l10n.dart';
import 'profile_text_field.dart';

class ProfileFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;

  const ProfileFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: ProfileTextField(
                label: S.current.first_name,
                controller: firstNameController,
                validator: _validateFirstName,
                icon: const Icon(Ionicons.person_outline),
              ),
            ),
            Expanded(
              child: ProfileTextField(
                label: S.current.last_name,
                controller: lastNameController,
                validator: _validateLastName,
                icon: const Icon(Ionicons.person_outline),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ProfileTextField(
          label: S.current.username,
          controller: usernameController,
          validator: _validateUsername,
          icon: const Icon(Ionicons.person_outline),
        ),
      ],
    );
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) return S.current.enterFirstName;
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) return S.current.enterLastName;
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return S.current.enterUsername;
    if (value.length < 3) return S.current.minUsername;
    return null;
  }
}
