import 'package:flutter/material.dart';


class FractionallyPageWrapperBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, double _remainingWidth) builder;
  final double factor;
  final double maxW;

  const FractionallyPageWrapperBuilder({
    Key? key,
    required this.builder,
    this.factor = .95,
    this.maxW = 900,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _w = MediaQuery.of(context).size.width;
    final _total = _w <= maxW ? _w : maxW;
    final _remainingWidth = factor * _total;

    return _FractionallyPageWrapper(
        factor: factor,
        maxW: maxW,
        child: builder(
          context,
          _remainingWidth,
        ));
  }
}

class FractionallyPageWrapper extends StatelessWidget {
  final Widget child;
  final double factor;
  final double maxW;

  const FractionallyPageWrapper({
    Key? key,
    required this.child,
    this.factor = .95,
    this.maxW = 900,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _FractionallyPageWrapper(
      child: child,
      factor: factor,
      maxW: maxW,
    );
  }
}

class _FractionallyPageWrapper extends StatelessWidget {
  final Widget child;
  final double factor;
  final double maxW;
  const _FractionallyPageWrapper({
    Key? key,
    required this.child,
    required this.factor,
    required this.maxW,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxW),
      child: FractionallySizedBox(
        widthFactor: factor,
        child: child,
      ),
    );
  }
}
