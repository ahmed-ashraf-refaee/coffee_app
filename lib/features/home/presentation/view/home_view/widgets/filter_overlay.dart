import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper/ui_helpers.dart';

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({super.key, required this.onFilter});
  final VoidCallback onFilter;
  @override
  State<FilterOverlay> createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  @override
  Widget build(BuildContext context) {
    return OverlayContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("filters!!"),
          CustomElevatedButton(
            onPressed: widget.onFilter,
            child: const Text("apply filters"),
          ),
        ],
      ),
    );
  }
}

void filterOverlay(BuildContext context, VoidCallback onFilter) =>
    UiHelpers.showOverlay(
      context: context,
      child: FilterOverlay(onFilter: onFilter),
    );
