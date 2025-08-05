import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../../generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(S.current.title, style: TextStyles.bold32)],
      ),
    );
  }
}
