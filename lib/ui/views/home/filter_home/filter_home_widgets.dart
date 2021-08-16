part of 'filter_home.dart';

const _sizePic = 32.0;
const _spacer = SizedBox(height: 8);

typedef _SelectFilterCallBack = void Function(FilterHomeModel filterSelected);

//UTILS WIDGETS
class _HeaderSection extends StatelessWidget {
  final String text;
  const _HeaderSection(this.text);

  @override
  Widget build(BuildContext context) {
    return CryptoText.b1(
      text,
      fontWeight: FontWeight.bold,
    );
  }
}

class _SvgPicture extends StatelessWidget {
  final String svg;
  const _SvgPicture(this.svg);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      width: _sizePic,
      height: _sizePic,
    );
  }
}

class _IconPicture extends StatelessWidget {
  final IconData icon;
  const _IconPicture(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _sizePic,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondaryVariant,
          size: 24,
        ));
  }
}

abstract class _ISection extends StatelessWidget {
  final String text;
  final Widget picture;

  _ISection({
    Key? key,
    required this.text,
    required this.picture,
  }) : super(key: key);

  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final double textW = constraint.maxWidth - 48;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              picture,
              SizedBox(width: 16),
              SizedBox(width: textW, child: CryptoText.b1(text))
            ],
          ),
        );
      },
    );
  }
}

class _SectionButton extends _ISection {
  final VoidCallback onTap;

  _SectionButton({
    required String text,
    required Widget picture,
    required this.onTap,
  }) : super(
          text: text,
          picture: picture,
        );

  Widget _button(Widget child) => RippleButton(child: child, onTap: onTap);
  @override
  Widget build(BuildContext context) => _button(body(context));
}

class _SectionTag extends _ISection {
  _SectionTag({
    required String text,
    required Widget picture,
  }) : super(
          text: text,
          picture: picture,
        );

  @override
  Widget build(BuildContext context) => body(context);
}

//WIDGETS
class _SelectedBox extends StatelessWidget {
  final HomeVM model;
  final VoidCallback onTap;
  const _SelectedBox({Key? key, required this.model,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Visibility(
        visible: model.hasFilter,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondaryVariant,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _spacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CryptoText.b2(
                        model.selling
                            ? lang.vFilterSalesResult
                            : lang.vFilterBuysResult,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondaryVariant),
                    CryptoChildButton(
                        onTap: onTap,
                        color: Theme.of(context).colorScheme.background,
                        child: Icon(Icons.close,
                            color:
                                Theme.of(context).colorScheme.secondaryVariant))
                  ],
                ),
                //SELECTED FILTER
                _getSelectedFilterWidget(context, model: model),
                _spacer,
              ],
            ),
          ),
        ));
  }
}

class _UserInfoFilters extends StatelessWidget {
  final HomeVM model;
  final _SelectFilterCallBack onTap;
  const _UserInfoFilters({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getMapFilterUserInfo(context, model: model)
          .entries
          .map((f) => _SectionButton(
                text: f.value.name,
                picture: _IconPicture(f.value.icon),
                onTap: () => onTap(model.filter.copyWith(filter: f.key)),
              ))
          .toList(),
    );
  }
}

class _CryptoFilter extends StatelessWidget {
  final HomeVM model;
  final _SelectFilterCallBack onTap;
  const _CryptoFilter({Key? key, required this.model, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return _SectionButton(
      text: lang.vFilterSelect,
      picture: _IconPicture(Icons.blur_circular),
      onTap: () {
        _dialog(context,
            sections: _sectionCryptos(model: model, onTap: onTap),
            title: lang.vFilterCryptos);
      },
    );
  }
}

class _PaymentFilter extends StatelessWidget {
  final HomeVM model;
  final _SelectFilterCallBack onTap;
  const _PaymentFilter({Key? key, required this.model, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return _SectionButton(
      text: lang.vFilterSelect,
      picture: _IconPicture(Icons.payments_outlined),
      onTap: () {
        _dialog(context,
            sections: _sectionPayments(model: model, onTap: onTap),
            title: lang.vFilterPayment);
      },
    );
  }
}

class _HeaderUserFilters extends StatelessWidget {
  const _HeaderUserFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return _HeaderSection(lang.vFilterUserInfo);
  }
}

class _HeaderCryptoFilters extends StatelessWidget {
  const _HeaderCryptoFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return _HeaderSection(lang.vFilterCryptos);
  }
}

class _HeaderPaymentFilters extends StatelessWidget {
  const _HeaderPaymentFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return _HeaderSection(lang.vFilterPayment);
  }
}

class _SpacerFilterSelected extends StatelessWidget {
  final HomeVM model;
  const _SpacerFilterSelected({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(visible: model.hasFilter, child: _spacer);
  }
}

//HELPERS
String _getFilterHeader(BuildContext context, HomeVM model) {
  final lang = S.of(context);
  return model.selling
      ? lang.vFilterAppBarFilterSale
      : lang.vFilterAppBarFilterBuys;
}

List<_SectionButton> _sectionCryptos({
  required HomeVM model,
  required _SelectFilterCallBack onTap,
}) {
  return model.filter.cryptos
      .map((c) => _SectionButton(
          picture: _SvgPicture(cryptoDataHelper[c]!.picture),
          text: cryptoDataHelper[c]!.name,
          onTap: () => onTap(
                model.filter.copyWith(
                    filter: FilterHomeLeyend.Crypto, selectedCrypto: c),
              )))
      .toList();
}

List<_SectionButton> _sectionPayments({
  required HomeVM model,
  required _SelectFilterCallBack onTap,
}) {
  return model.filter.payments
      .map((p) => _SectionButton(
            picture: _IconPicture(Icons.payment_outlined),
            text: p,
            onTap: () => onTap(model.filter.copyWith(
                filter: FilterHomeLeyend.Payment, selectedPayment: p)),
          ))
      .toList();
}

Future<void> _dialog(
  BuildContext context, {
  required List<Widget> sections,
  required String title,
}) async {
  await showDialog(
    context: context,
    builder: (context) => ModalSelector(
      title: title,
      children: sections,
      paddingHBody: 10,
    ),
  );
}

Map<FilterHomeLeyend, _FiltersUserInfoWidgetModel> _getMapFilterUserInfo(
  BuildContext context, {
  required HomeVM model,
}) {
  final lang = S.of(context);
  return {
    FilterHomeLeyend.Valor: _FiltersUserInfoWidgetModel(
      icon: Icons.star_border_rounded,
      name: model.selling
          ? lang.vFilterBestSalersOpinion
          : lang.vFilterBestBuyersOpinion,
    ),
    FilterHomeLeyend.Rating: _FiltersUserInfoWidgetModel(
      icon: Icons.favorite_border,
      name: lang.vFilterBestVotesConfidence,
    )
  };
}

Widget _getSelectedFilterWidget(
  BuildContext context, {
  required HomeVM model,
}) {
  final filterSelected = model.filter;

  if (filterSelected.filter == FilterHomeLeyend.Valor ||
      filterSelected.filter == FilterHomeLeyend.Rating) {
    final filterUser =
        _getMapFilterUserInfo(context, model: model)[filterSelected.filter];

    return _SectionTag(
      text: filterUser!.name,
      picture: _IconPicture(filterUser.icon),
    );
  }

  if (filterSelected.filter == FilterHomeLeyend.Crypto) {
    return _SectionTag(
      text: cryptoDataHelper[filterSelected.selectedCrypto]!.name,
      picture:
          _SvgPicture(cryptoDataHelper[filterSelected.selectedCrypto]!.picture),
    );
  }

  if (filterSelected.filter == FilterHomeLeyend.Payment) {
    return _SectionTag(
      text: filterSelected.selectedPayment ?? '',
      picture: _IconPicture(Icons.payment),
    );
  }

  return SizedBox();
}
