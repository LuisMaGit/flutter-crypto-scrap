import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';

class Loader extends StatefulWidget {
  final Widget child;
  const Loader({Key? key, required this.child}) : super(key: key);
  const Loader.logo({Key? key})
      : child = const CryptoTextLogo(),
        super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late CurvedAnimation _curvedAnimation;

  bool isPrimary = true;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _curvedAnimation =
        CurvedAnimation(parent: _animation, curve: Curves.fastOutSlowIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.value = 0;
              _animationController.forward();
              setState(() {
                isPrimary = !isPrimary;
              });
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _getXAlignment() => 2 * _curvedAnimation.value - 1;

  double _getW() {
    final num x = _curvedAnimation.value;
    final y = -4 * pow(x, 2) + 4 * x;
    return y * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.child,
          SizedBox(height: 12),
          AnimatedBuilder(
            animation: _curvedAnimation,
            builder: (context, _) => Container(
              width: 160,
              height: 6,
              alignment: Alignment(_getXAlignment(), 0),
              child: Container(
                width: _getW(),
                height: 6,
                decoration: BoxDecoration(
                    color: isPrimary
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
