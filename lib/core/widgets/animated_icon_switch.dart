import 'package:flutter/material.dart';

import 'prettier_tap.dart';

class AnimatedIconSwitch extends StatefulWidget {
  const AnimatedIconSwitch({
    super.key,
    required this.children,
    this.initialState = false,
    this.onChanged,
  }) : assert(children.length == 2);

  final List<Icon> children;

  final bool initialState;
  final ValueChanged<bool>? onChanged;

  @override
  State<AnimatedIconSwitch> createState() => _AnimatedIconSwitchState();
}

class _AnimatedIconSwitchState extends State<AnimatedIconSwitch> {
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
        child: isToggled ? widget.children[1] : widget.children[0],
      ),
    );
  }
}
