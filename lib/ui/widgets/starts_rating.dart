import 'package:flutter/material.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double sizeStars;

  StarRating({this.rating = .0, this.sizeStars = 20});

  Icon buildStar(int index, Color color) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border_rounded,
        color: color,
        size: sizeStars,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half_rounded,
        color: color,
        size: sizeStars,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: sizeStars,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final List<Icon> starts = List.generate(
        5, (index) => buildStar(index, Theme.of(context).colorScheme.primary));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      ...starts,
      Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: CryptoText.caption(rating.toString() + '/' + '5'))
    ]);
  }
}
