import 'package:flutter/material.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';

class Kyc extends StatelessWidget {
  final bool active;
  const Kyc({Key? key, this.active = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          color: active ? Colors.green : Colors.redAccent,
          size: 20,
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: CryptoText.b2('KYC'),
        ),
      ],
    );
  }
}
