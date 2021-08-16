import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? borderRadius;
  final void Function() onTap;

  const RippleButton({
    required this.child,
    required this.onTap,
    this.color = Colors.transparent,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius:
          borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
        child: child,
      ),
    );
  }
}
