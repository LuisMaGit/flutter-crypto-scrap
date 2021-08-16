part of 'offers_user.dart';

//WIDGETS
class _AppBarMobile extends PreferredSize {
  _AppBarMobile() : super(child: SizedBox(), preferredSize: Size(0, 0));

  Size get preferredSize => Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    final _w = MediaQuery.of(context).size.width;

    return SimpleAppBar(
      paddingVerticalBackButton: 7,
      titleWidget: Row(
        children: [
          //AVATAR
          Avatar(
              name: 'Occaecat mollit fugiat esse et sint laboris ea laboris.',
              picture: null,
              radius: 20),
          SizedBox(width: 20),
          //NAME + REGISTRATION DATE
          Container(
              width: _w - 165,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //NAME
                    CryptoText.b1('Id cAnim sunt ',
                        maxLines: 2, fontWeight: FontWeight.bold),
                    //KYC
                    Kyc(active: true),
                  ])),
        ],
      ),
    );
  }
}

class _InformationSection extends StatelessWidget {
  const _InformationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lang = S.of(context);
    return Wrap(
      runSpacing: 20,
      spacing: 20,
      children: [
        //REGISTRATION DATE
        _UserInfo(
            header: _lang.vOffersRegisterDate,
            body: '21/21/21',
            icon: Icons.calendar_today_outlined),
        //CONFIDENCE
        _UserInfo(
            header: _lang.vOffersVotesConfidence,
            body: '10',
            icon: Icons.favorite_border),
        //IGNORES
        _UserInfo(
          header: _lang.vOffersUserIgnore,
          body: '10',
          icon: Icons.block,
        ),
        _mediumSpacer,
      ],
    );
  }
}

class _SwitcherSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _lang = S.of(context);
    final model = Provider.of<OffersUserVM>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mediumSpacer,
        //SWITCH: OFERTAS VENTA/COMPRA
        Row(
          children: [
            CryptoText.b2(
              _lang.vOffersUserOffers,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 16),
            Switcher(
                backgroundColor: model.theme == ThemeModeApp.Dark
                    ? Theme.of(context).colorScheme.onBackground
                    : Theme.of(context).colorScheme.onPrimary,
                buttonColor: Theme.of(context).colorScheme.primary,
                text1: '\t${_lang.vOffersUserOffersSelling}\t',
                text2: '\t${_lang.vOffersUserOffersBuying}\t',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: kWhite, fontWeight: FontWeight.bold),
                onChanged: model.changeScreen)
          ],
        ),
        const SizedBox(height: 10),
        //RATING: SALE/BUY
        LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth - 170),
                child: CryptoText.b2(
                    model.isSalesOffers
                        ? _lang.vOffersSalesCalifaction
                        : _lang.vOffersBuyCalifaction,
                    maxLines: 2,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              StarRating(
                sizeStars: 24,
                rating: 4.5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardOffers extends StatelessWidget {
  final int index;
  const _CardOffers({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OffersUserVM>(context);
    return Column(
      children: [
        _bigSpacer,
        LayoutBuilder(
          builder: (context, constraints) {
            final sizeBody = constraints.maxWidth - 80;
            return OfferSection(
                idx: index,
                cryptoCode: CryptoCode.TRX,
                sizeBody: sizeBody,
                interval: 'interval ${model.isSalesOffers}',
                salesValue: 'salesValue',
                payment: 'payment');
          },
        ),
        ButtonsOfferSection(
          onTapShare: () {},
          onTapSubmitOffer: () {},
        ),
        Divider(
            height: 6,
            color: Theme.of(context).colorScheme.secondaryVariant,
            thickness: 1),
        _bigSpacer,
      ],
    );
  }
}

//WIDGETS HELPERS
class _UserInfo extends StatelessWidget {
  final String header;
  final String body;
  final IconData icon;
  const _UserInfo({
    Key? key,
    required this.header,
    required this.body,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.secondaryVariant,
              size: 20,
            ),
            SizedBox(width: 5),
            RichText(
                text: TextSpan(
              children: [
                TextSpan(
                    text: header,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: body, style: Theme.of(context).textTheme.bodyText1),
              ],
            ))
          ],
        );
      },
    );
  }
}
