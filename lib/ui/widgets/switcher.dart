import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:scrap/ui/styles/kStyles.dart';

class Switcher extends StatefulWidget {
  final String text1;
  final String text2;
  final Color backgroundColor;
  final Color buttonColor;
  final TextStyle textStyle;
  final bool startAtLeft;
  final void Function(bool value) onChanged;

  const Switcher({
    required this.backgroundColor,
    required this.buttonColor,
    required this.text1,
    required this.text2,
    required this.textStyle,
    required this.onChanged,
    this.startAtLeft = true,
  });
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _curvedAnimation =
        CurvedAnimation(parent: _animation, curve: Curves.easeIn);
  }

  Future<void> fowardAnimation({double value = 0}) async {
    _animationController.value = value;
    await _animationController.forward();
  }

  Future<void> reverseAnimation({double value = 1}) async {
    _animationController.value = value;
    await _animationController.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, _) => SwitcherRenderObject(
            backgroundColor: widget.backgroundColor,
            buttonColor: widget.buttonColor,
            text1: widget.text1,
            text2: widget.text2,
            textStyle: widget.textStyle,
            onChanged: widget.onChanged,
            startAtLeft: widget.startAtLeft,
            forwardAnimation: fowardAnimation,
            reverseAnimation: reverseAnimation,
            animation: _curvedAnimation.value,
          ));
}

class SwitcherRenderObject extends LeafRenderObjectWidget {
  final String text1;
  final String text2;
  final Color backgroundColor;
  final Color buttonColor;
  final TextStyle textStyle;
  final double animation;
  final void Function(bool isAtLeft) onChanged;
  final bool startAtLeft;
  final Future<void> Function({double value}) forwardAnimation;
  final Future<void> Function({double value}) reverseAnimation;

  SwitcherRenderObject({
    required this.backgroundColor,
    required this.buttonColor,
    required this.text1,
    required this.text2,
    required this.textStyle,
    required this.forwardAnimation,
    required this.reverseAnimation,
    required this.animation,
    required this.onChanged,
    required this.startAtLeft,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => SwitchRenderBox(
        text1: text1,
        text2: text2,
        backgroundColor: backgroundColor,
        buttonColor: buttonColor,
        textStyle: textStyle,
        startAtLeft: startAtLeft,
        fowardAnimation: forwardAnimation,
        reverseAnimation: reverseAnimation,
        animation: animation,
        onChanged: onChanged,
      );

  @override
  void updateRenderObject(
      BuildContext context, covariant SwitchRenderBox renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject
      ..setText1 = text1
      ..setText2 = text2
      ..setBackgroundColor = backgroundColor
      ..setButtonColor = buttonColor
      ..setTextStyle = textStyle
      ..setAnimation = animation;
  }
}

class SwitchRenderBox extends RenderBox {
  final String text1;
  final String text2;
  final Color backgroundColor;
  final Color buttonColor;
  final TextStyle textStyle;
  final double animation;
  final bool startAtLeft;
  void Function(bool isAtLeft) onChanged;
  final Future<void> Function({double value}) fowardAnimation;
  final Future<void> Function({double value}) reverseAnimation;

  SwitchRenderBox({
    required this.text1,
    required this.text2,
    required this.backgroundColor,
    required this.buttonColor,
    required this.textStyle,
    required this.fowardAnimation,
    required this.reverseAnimation,
    required this.animation,
    required this.onChanged,
    required this.startAtLeft,
  })   : _text1 = text1,
        _text2 = text2,
        _backgroundColor = backgroundColor,
        _buttonColor = buttonColor,
        _textStyle = textStyle,
        _onChanged = onChanged,
        _startAtLeft = startAtLeft,
        _animation = animation;

  //Props
  String _text1;
  String _text2;
  Color _backgroundColor;
  Color _buttonColor;
  TextStyle _textStyle;
  double _animation;
  bool _startAtLeft;
  void Function(bool isAtLeft) _onChanged;
  //Gestures
  late HorizontalDragGestureRecognizer _drag;
  late TapGestureRecognizer _tap;
  //Painters
  late TextPainter _text1Painter;
  late TextPainter _text2Painter;
  //Sizes
  late double _height;
  late double _width;
  late double _bubble1Width;
  late double _bubble2Width;
  late double _bubbleWidth;
  late double _maxBubbleWidth;
  late double _minBubbleWidth;
  late double _centerPositionX1Bubble;
  late double _centerPositionX2Bubble;
  late double _centerPositionYBubble;
  late double _centerPositionXBubble;
  late double _mSizeBubble;
  late double _mCenterBubble;
  double _dx = 0;
  static const double _paddingText = 10.00;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    //Drag
    _drag = HorizontalDragGestureRecognizer(debugOwner: this)
      ..onUpdate = (DragUpdateDetails details) {
        _horizontalDragHandler(details.localPosition);
      }
      ..onEnd = (DragEndDetails details) {
        _horizontalDragEnd();
      };
    _tap = TapGestureRecognizer(debugOwner: this)
      ..onTapUp = (TapUpDetails details) {
        _tapHandler(details.localPosition);
      };
  }

  @override
  void detach() {
    super.detach();
    _drag.dispose();
    _tap.dispose();
  }

  @override
  void performLayout() {
    _text1Painter = TextPainter(
        text: TextSpan(text: _text1, style: _textStyle),
        textAlign: TextAlign.left,
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: 200);
    _text2Painter = TextPainter(
        text: TextSpan(text: _text2, style: _textStyle),
        textAlign: TextAlign.left,
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: 200);
    _height = _text1Painter.height + 2 * _paddingText;
    _width = _text1Painter.width + _text2Painter.width + 4 * _paddingText;
    _bubble1Width = _text1Painter.width + 2 * _paddingText;
    _bubble2Width = _text2Painter.width + 2 * _paddingText;
    _centerPositionX1Bubble = _bubble1Width / 2;
    _centerPositionX2Bubble = _width - _bubble2Width / 2;
    _centerPositionYBubble = _height / 2;

    _bubbleWidth = _startAtLeft ? _bubble1Width : _bubble2Width;
    _centerPositionXBubble =
        _startAtLeft ? _centerPositionX1Bubble : _centerPositionX2Bubble;
    final double maxW =
        constraints.maxWidth == double.infinity ? _width : constraints.maxWidth;
    final double maxH = constraints.maxHeight == double.infinity
        ? _height
        : constraints.maxHeight;
    size = Size(maxW, maxH);

    _mSizeBubble = _bubble2Width - _bubble1Width;
    _mCenterBubble = _centerPositionX2Bubble - _centerPositionX1Bubble;

    _maxBubbleWidth = max(_bubble1Width, _bubble2Width);
    _minBubbleWidth = min(_bubble1Width, _bubble2Width);
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      _drag.addPointer(event);
      _tap.addPointer(event);
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return size.contains(position);
  }

  set setText1(String value) {
    if (_text1 == value) return;
    _text1 = value;
    markNeedsLayout();
  }

  set setText2(String value) {
    if (_text2 == value) return;
    _text2 = value;
    markNeedsLayout();
  }

  set setBackgroundColor(Color value) {
    if (_backgroundColor == value) return;
    _backgroundColor = value;
    markNeedsPaint();
  }

  set setButtonColor(Color value) {
    if (_buttonColor == value) return;
    _buttonColor = value;
    markNeedsPaint();
  }

  set setTextStyle(TextStyle value) {
    if (_textStyle == value) return;
    _textStyle = value;
    markNeedsPaint();
  }

  set setAnimation(double value) {
    if (_animation == value) return;
    _animation = value;
    _animateBubble(_animation);
  }

  double _bubbleWidthByOneFactor(double factor) {
    double w = _mSizeBubble * factor + _bubble1Width;
    if (w >= _maxBubbleWidth) return _maxBubbleWidth;
    if (w <= _minBubbleWidth) return _minBubbleWidth;

    return w;
  }

  double _bubbleCenterByOneFactor(double factor) {
    double center = _mCenterBubble * factor + _centerPositionX1Bubble;
    if (center <= _centerPositionX1Bubble) return _centerPositionX1Bubble;
    if (center >= _centerPositionX2Bubble) return _centerPositionX2Bubble;

    return center;
  }

  void _animateBubble(double factor) {
    _centerPositionXBubble = _bubbleCenterByOneFactor(factor);
    _bubbleWidth = _bubbleWidthByOneFactor(factor);
    markNeedsPaint();
  }

  double _factorByDx() => _dx / _width;

  //Gestures
  void _horizontalDragHandler(Offset localPosition) {
    _dx = localPosition.dx;
    _animateBubble(_factorByDx());
    if (_centerPositionXBubble == _centerPositionX1Bubble) {
      _limitPositionAtLeft(true);
    }
    if (_centerPositionXBubble == _centerPositionX2Bubble) {
      _limitPositionAtLeft(false);
    }
    markNeedsPaint();
  }

  Future<void> _tapHandler(Offset details) async {
    if (_startAtLeft) {
      if (details.dx <= _bubble1Width) return;
      _limitPositionAtLeft(false);
      await fowardAnimation();
      return;
    }

    if (details.dx > _bubble1Width) return;
    await reverseAnimation();
    _limitPositionAtLeft(true);
  }

  Future<void> _horizontalDragEnd() async {
    if (_dx <= _width / 2) {
      _limitPositionAtLeft(true);
      await reverseAnimation(value: _factorByDx());
      return;
    }

    _limitPositionAtLeft(false);
    await fowardAnimation(value: _factorByDx());
  }

  void _limitPositionAtLeft(bool atLeft) {
    _startAtLeft = atLeft;
    _onChanged(atLeft);
  }

  //Paint
  void _drawBack(Canvas canvas) {
    //BACK
    final Paint containerPainter = Paint()..color = _backgroundColor;
    final Rect rectContainer =
        Rect.fromPoints(Offset(0, 0), Offset(_width, _height));
    final RRect rRectContainer = RRect.fromRectAndCorners(
      rectContainer,
      topLeft: Radius.circular(kButtonsBorderRadius),
      topRight: Radius.circular(kButtonsBorderRadius),
      bottomLeft: Radius.circular(kButtonsBorderRadius),
      bottomRight: Radius.circular(kButtonsBorderRadius),
    );
    canvas.drawRRect(rRectContainer, containerPainter);
  }

  void _drawTexts(Canvas canvas) {
    //TEXTS
    _text1Painter.paint(canvas, Offset(_paddingText, _paddingText));
    _text2Painter.paint(
        canvas, Offset(_bubble1Width + _paddingText, _paddingText));
  }

  void _drawBubble(Canvas canvas) {
    final Paint bubblePainter = Paint()..color = _buttonColor;
    final Rect rectContainer = Rect.fromCenter(
        center: Offset(_centerPositionXBubble, _centerPositionYBubble),
        width: _bubbleWidth,
        height: _height);
    final RRect rRectContainer = RRect.fromRectAndCorners(
      rectContainer,
      topLeft: Radius.circular(kButtonsBorderRadius),
      topRight: Radius.circular(kButtonsBorderRadius),
      bottomLeft: Radius.circular(kButtonsBorderRadius),
      bottomRight: Radius.circular(kButtonsBorderRadius),
    );
    canvas.drawRRect(rRectContainer, bubblePainter);
  }

  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    _drawBack(canvas);
    _drawBubble(canvas);
    _drawTexts(canvas);

    canvas.restore();
  }
}
