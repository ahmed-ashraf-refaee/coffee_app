import 'package:flutter/material.dart';

class ProfileTileDivider extends StatelessWidget {
  const ProfileTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color(0xff5D6165).withAlpha((85 * 255 / 100).toInt()),
      indent: 16,
      endIndent: 16,
      thickness: 1,
    );
  }
}
