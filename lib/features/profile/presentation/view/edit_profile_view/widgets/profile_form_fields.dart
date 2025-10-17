import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
                label: 'First Name',
                controller: firstNameController,
                validator: _validateFirstName,
                icon: const Icon(Ionicons.person_outline),
              ),
            ),
            Expanded(
              child: ProfileTextField(
                label: 'Last Name',
                controller: lastNameController,
                validator: _validateLastName,
                icon: const Icon(Ionicons.person_outline),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ProfileTextField(
          label: 'Username',
          controller: usernameController,
          validator: _validateUsername,
          icon: const Icon(Ionicons.person_outline),
        ),
      ],
    );
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter first name';
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter last name';
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Please enter username';
    if (value.length < 3) return 'Username must be at least 3 characters';
    return null;
  }
}
