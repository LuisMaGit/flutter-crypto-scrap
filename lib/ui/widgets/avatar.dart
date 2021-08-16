import 'package:flutter/material.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/image_network_custom.dart';

class Avatar extends StatelessWidget {
  final String name;
  final String? picture;
  final double radius;

  const Avatar({Key? key, this.name = '', this.picture, this.radius = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _getInitial() {
      if (name.isEmpty) return '';
      return name.substring(0, 1).toUpperCase();
    }

    return CircleAvatar(
        radius: radius,
        backgroundColor: picture == null
            ? Theme.of(context).colorScheme.primaryVariant
            : null,
        child: picture != null
            ? ImageNetworkCustom(url: picture!)
            : CryptoText.h2(
                _getInitial(),
                color: kWhite,
                fontSize: radius,
              ));
  }
}
