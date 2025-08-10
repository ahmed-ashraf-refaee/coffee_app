import 'package:flutter/material.dart';

import 'prettier_tap.dart';

class IconAnimatedSwitch extends StatefulWidget {
  const IconAnimatedSwitch({
    super.key,
    required this.icons,
    this.initialState = false,
    this.onChanged,
  }) : assert(icons.length == 2);

  final List<Icon> icons;
  final bool initialState;
  final ValueChanged<bool>? onChanged;

  @override
  State<IconAnimatedSwitch> createState() => _IconAnimatedSwitchState();
}

class _IconAnimatedSwitchState extends State<IconAnimatedSwitch> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialState;
  }

  void _onPressed() {
    setState(() {
      isToggled = !isToggled;
    });
    widget.onChanged?.call(isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: 3,
      onPressed: _onPressed,
      child: SizedBox(
        width: 48,
        height: 48,
        child: isToggled ? widget.icons[1] : widget.icons[0],
      ),
    );
  }
}
