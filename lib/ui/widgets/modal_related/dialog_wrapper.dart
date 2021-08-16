import 'package:flutter/material.dart';
import 'package:scrap/ui/styles/kStyles.dart';

class DialogWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool clip;

  const DialogWrapper({
    Key? key,
    required this.child,
    this.clip = false,
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets +
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

    return AnimatedPadding(
      padding: effectivePadding,
      duration: const Duration(seconds: 200),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kButtonsBorderRadius),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 200, maxWidth: 600),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onBackground),
                child: Padding(
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
