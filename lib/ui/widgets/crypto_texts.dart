import 'package:flutter/material.dart';
import 'package:scrap/utils/assets_helpers.dart';

enum StyleType {
  h1,
  h1Cursive,
  h2,
  b1,
  b2,
  capt,
}

class CryptoText extends StatelessWidget {
  final String text;
  final StyleType styleType;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int maxLines;

  const CryptoText.h1(this.text,
      {this.color, this.maxLines = 1, this.fontWeight, this.fontSize})
      : styleType = StyleType.h1;
  const CryptoText.h1Cursive(this.text,
      {this.color, this.maxLines = 1, this.fontWeight, this.fontSize})
      : styleType = StyleType.h1Cursive;
  const CryptoText.h2(this.text,
      {this.color, this.maxLines = 1, this.fontWeight, this.fontSize})
      : styleType = StyleType.h2;
  const CryptoText.b1(this.text,
      {this.color, this.maxLines = 1, this.fontWeight, this.fontSize})
      : styleType = StyleType.b1;
  const CryptoText.b2(this.text,
      {this.color, this.maxLines = 1, this.fontWeight, this.fontSize})
      : styleType = StyleType.b2;
  const CryptoText.caption(this.text,
      {this.color, this.maxLines = 1, this.fontWeight, this.fontSize})
      : styleType = StyleType.capt;

  @override
  Widget build(BuildContext context) {
    TextStyle? getStyle() {
      switch (styleType) {
        case StyleType.h1:
          return Theme.of(context).textTheme.headline1;
        case StyleType.h1Cursive:
          return Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontFamily: Fonts.RubikItalicBold);
        case StyleType.h2:
          return Theme.of(context).textTheme.headline2;
        case StyleType.b1:
          return Theme.of(context).textTheme.bodyText1;
        case StyleType.b2:
          return Theme.of(context).textTheme.bodyText2;
        case StyleType.capt:
          return Theme.of(context).textTheme.caption;
        default:
      }
    }

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: TextAlign.left,
      style: getStyle()!.copyWith(
        color: color ?? getStyle()!.color,
        fontWeight: fontWeight ?? getStyle()!.fontWeight,
        fontSize: fontSize ?? getStyle()!.fontSize,
      ),
    );
  }
}

class CryptoTextLogo extends StatelessWidget {
  const CryptoTextLogo();
  @override
  Widget build(BuildContext context) {
    return RichText(
        textScaleFactor: 1,
        maxLines: 1,
        text: TextSpan(children: [
          TextSpan(
              text: 'crypto',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontFamily: Fonts.RubikItalicBold,
                  fontSize: 26)),
          TextSpan(
              text: 'Scrap',
              style: TextStyle(
                fontSize: 26,
                fontFamily: Fonts.RubikItalicBold,
                color: Theme.of(context).colorScheme.primary,
              )),
        ]));
  }
}
