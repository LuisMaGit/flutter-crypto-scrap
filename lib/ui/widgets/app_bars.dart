import 'package:flutter/material.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';

class AppBarNull extends PreferredSize {
  AppBarNull() : super(child: SizedBox(), preferredSize: Size(0, 0));

  @override
  Size get preferredSize => Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class SimpleAppBar extends PreferredSize {
  final String title;
  final double elevation;
  final Widget? leading;
  final Widget? titleWidget;
  final bool withLeading;
  final VoidCallback? onBackHandler;
  final List<Widget>? actions;
  final double height;
  final double paddingVerticalBackButton;
  SimpleAppBar({
    this.title = '',
    this.titleWidget,
    this.elevation = 0,
    this.leading,
    this.withLeading = true,
    this.onBackHandler,
    this.actions,
    this.height = kAppBarHeight,
    this.paddingVerticalBackButton = 5,
  }) : super(child: SizedBox(), preferredSize: Size(0, 0));

  @override
  Size get preferredSize => Size(double.infinity, height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: elevation,
      titleSpacing: 0,
      leading: withLeading
          ? Padding(
              padding: EdgeInsets.symmetric(
                  vertical: paddingVerticalBackButton, horizontal: 8),
              child: leading ?? CryptoBackButton(onTap: onBackHandler))
          : null,
      actions: actions,
      title: titleWidget ??
          CryptoText.h1Cursive(title,
              color: Theme.of(context).colorScheme.secondary),
    );
  }
}
