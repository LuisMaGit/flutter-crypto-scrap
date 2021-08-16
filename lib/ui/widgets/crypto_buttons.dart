import 'package:flutter/material.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/ripple_button.dart';

class CryptoTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? colorText;
  final EdgeInsets padding;

  const CryptoTextButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.colorText,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: CryptoText.b1(text, color: colorText),
      ),
    );
  }
}

class CryptoRoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CryptoRoundedButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: onTap,
      borderRadius: kButtonsBorderRadius,
      color: Theme.of(context).colorScheme.primary,
      child: Align(
        alignment: Alignment.center,
        child: CryptoText.b2(text, color: kWhite),
      ),
    );
  }
}

class CryptoChildButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback onTap;

  const CryptoChildButton(
      {Key? key, required this.child, required this.onTap, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RippleButton(
      borderRadius: kButtonsBorderRadius,
      color: color ?? Theme.of(context).colorScheme.onBackground,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
        child: child,
      ),
    );
  }
}

class CryptoBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CryptoBackButton({Key? key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RippleButton(
      borderRadius: 20,
      color: Theme.of(context).colorScheme.onBackground,
      onTap: onTap ?? Navigator.of(context).pop,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        width: 40,
        height: 40,
        child: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
