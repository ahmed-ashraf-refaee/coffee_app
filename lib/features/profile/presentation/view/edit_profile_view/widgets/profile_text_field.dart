import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Icon? icon;
  final String? Function(String?) validator;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: label, prefixIcon: icon),
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: validator,
    );
  }
}
