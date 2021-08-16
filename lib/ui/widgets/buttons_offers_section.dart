import 'package:flutter/material.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/ripple_button.dart';

class ButtonsOfferSection extends StatelessWidget {
  final VoidCallback onTapShare;
  final VoidCallback onTapSubmitOffer;

  const ButtonsOfferSection(
      {Key? key, required this.onTapShare, required this.onTapSubmitOffer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ButtonOffer(
            onTap: onTapShare,
            icon: Icons.share_outlined,
            text: lang.vOffersShare,
          ),
          const SizedBox(width: 20),
          _ButtonOffer(
            onTap: onTapSubmitOffer,
            icon: Icons.swap_horiz_rounded,
            text: lang.vOffersTransac,
          ),
        ],
      ),
    );
  }
}

class _ButtonOffer extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _ButtonOffer(
      {Key? key, required this.icon, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: RippleButton(
          onTap: onTap,
          borderRadius: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    size: 28),
                SizedBox(width: 10),
                CryptoText.b1(text),
              ],
            ),
          ),
        ));
  }
}
