import 'package:flutter/material.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/modal_related/dialog_wrapper.dart';

class ModalSelector extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final double paddingHBody;
  const ModalSelector({
    Key? key,
    required this.children,
    this.title = '',
    this.paddingHBody = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
        padding: const EdgeInsets.all(0),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              title: CryptoText.b1(title, fontWeight: FontWeight.bold),
              elevation: 0,
              titleSpacing: 12,
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 40,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              actions: [
                Padding(
                    padding: const EdgeInsets.all(4),
                    child: CryptoChildButton(
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                      onTap: Navigator.of(context).pop,
                    )),
              ],
            ),
            SliverPadding(
                padding: EdgeInsets.only(
                    bottom: 8, left: paddingHBody, right: paddingHBody),
                sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed(children))),
          ],
        ));
  }
}
