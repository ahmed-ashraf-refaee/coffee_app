import 'package:flutter/material.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../main.dart';

class ProfileInfoDisplay extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfileInfoDisplay({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$firstName $lastName', style: TextStyles.bold20),
        Text(
          email,
          style: TextStyles.medium12.copyWith(
            color: context.colors.onSecondary,
          ),
        ),
      ],
    );
  }
}
