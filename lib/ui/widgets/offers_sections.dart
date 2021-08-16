import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/widgets/avatar.dart';
import 'package:scrap/ui/widgets/buttons_offers_section.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/kyc.dart';
import 'package:scrap/ui/widgets/ripple_button.dart';
import 'package:scrap/ui/widgets/starts_rating.dart';
import 'package:scrap/utils/crypto_helper.dart';
import 'package:scrap/utils/enums.dart';

const spacerCircleBody = SizedBox(width: 20);

class SalersCard extends StatelessWidget {
  final int idx;
  final CryptoCode cryptoCode;
  final String? picture;
  final String name;
  final double rating;
  final String confidence;
  final String ingnore;
  final String interval;
  final String salesValue;
  final String payment;
  final void Function(int idx) goToUserOffers;

  const SalersCard({
    Key? key,
    required this.idx,
    this.picture,
    required this.name,
    required this.rating,
    required this.cryptoCode,
    required this.confidence,
    required this.ingnore,
    required this.interval,
    required this.salesValue,
    required this.payment,
    required this.goToUserOffers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sizeBody = constraints.maxWidth - 80;
          final socialStatW = (sizeBody - 80) / 2;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              RippleButton(
                onTap: () => goToUserOffers(idx),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //AVATAR
                      Avatar(name: name, picture: picture),
                      spacerCircleBody,
                      //NAME + RATING + KYC
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NAME
                          ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: sizeBody),
                              child: CryptoText.b1(name, maxLines: 2)),
                          const SizedBox(height: 10),
                          //RATING + KYC
                          Wrap(
                            children: [
                              Kyc(active: true),
                              const SizedBox(width: 10),
                              StarRating(rating: rating),
                            ],
                          ),
                          const SizedBox(height: 8),
                          //CONFIDENCE + IGNORE
                          Row(
                            children: [
                              _SocialStat(
                                  stat: confidence,
                                  icon: Icons.favorite_border,
                                  width: socialStatW),
                              const SizedBox(width: 20),
                              _SocialStat(
                                stat: ingnore,
                                icon: Icons.block,
                                width: socialStatW,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
              //AVATAR + NAME + RATING + KYC
              const SizedBox(height: 12),
              //OFFERS SECTION
              OfferSection(
                cryptoCode: cryptoCode,
                idx: idx,
                sizeBody: sizeBody,
                interval: interval,
                payment: payment,
                salesValue: salesValue,
              ),
              //BUTTONS SHARE + BUY
              Center(
                  child: ButtonsOfferSection(
                      onTapShare: () {}, onTapSubmitOffer: () {})),
              const SizedBox(height: 10),
              getDivider(context),
            ],
          );
        },
      ),
    );
  }
}

class OfferSection extends StatelessWidget {
  final int idx;
  final CryptoCode cryptoCode;
  final double sizeBody;
  final String interval;
  final String salesValue;
  final String payment;
  const OfferSection({
    Key? key,
    required this.idx,
    required this.cryptoCode,
    required this.sizeBody,
    required this.interval,
    required this.salesValue,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    Column sectionHeaderBody(String header, String body) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CryptoText.b2(header + ': ', fontWeight: FontWeight.bold),
        SizedBox(height: 4),
        CryptoText.b2(body, maxLines: 3),
        SizedBox(height: 10),
      ]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              cryptoDataHelper[cryptoCode]!.picture,
              width: 60,
            ),
            CryptoText.b2(
              cryptoDataHelper[cryptoCode]!.name,
              color: cryptoDataHelper[cryptoCode]!.color,
            )
          ],
        ),
        spacerCircleBody,
        //INTERVALO

        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: sizeBody),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              // spacing: 20,
              children: [
                sectionHeaderBody(lang.vHomeInverterval, interval),
                sectionHeaderBody(lang.vHomeSalesValue, salesValue),
                sectionHeaderBody(lang.vHomePaymentMethod, payment),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _SocialStat extends StatelessWidget {
  final IconData icon;
  final String stat;
  final double width;
  const _SocialStat({
    Key? key,
    required this.stat,
    required this.icon,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondaryVariant,
        ),
        SizedBox(width: 5),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: CryptoText.b2(stat),
        ),
      ],
    );
  }
}
