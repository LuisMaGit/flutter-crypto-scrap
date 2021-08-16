import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/models/app/filter_home_data_model.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/views/home/home_vm.dart';
import 'package:scrap/ui/widgets/app_bars.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/fractionally_page_wrapper.dart';
import 'package:scrap/ui/widgets/modal_related/modal_selector.dart';
import 'package:scrap/ui/widgets/ripple_button.dart';
import 'package:scrap/utils/crypto_helper.dart';
part 'filter_home_widgets.dart';

class _FiltersUserInfoWidgetModel {
  final String name;
  final IconData icon;

  const _FiltersUserInfoWidgetModel({
    required this.name,
    required this.icon,
  });
}

class FilterHomeMobile extends StatelessWidget {
  final HomeVM model;
  const FilterHomeMobile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: _getFilterHeader(context, model),
      ),
      body: FractionallyPageWrapper(
        maxW: double.infinity,
        child: ListView(
          padding: const EdgeInsets.only(left: 20),
          children: [
            _spacer,
            //SIGN SELECTED FILTER
            _SpacerFilterSelected(model: model),
            _SelectedBox(model: model, onTap: model.closeFilterFromMobile),
            _SpacerFilterSelected(model: model),
            //USER INFO
            _HeaderUserFilters(),
            _spacer,
            _UserInfoFilters(model: model, onTap: model.submitFilterFromMobile),
            _spacer,
            getDivider(context),
            const SizedBox(height: 16),
            //CRYPTOS
            _HeaderCryptoFilters(),
            _spacer,
            _CryptoFilter(
                model: model, onTap: model.submitDialogFilterFromMobile),
            _spacer,
            getDivider(context),
            const SizedBox(height: 16),
            //PAYMENT
            _HeaderPaymentFilters(),
            _PaymentFilter(
                model: model, onTap: model.submitDialogFilterFromMobile),
          ],
        ),
      ),
    );
  }
}

class FilterHomeDesktop extends StatelessWidget {
  const FilterHomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        //SIGN SELECTED FILTER
        CryptoText.h1(_getFilterHeader(context, model)),
        _SpacerFilterSelected(model: model),
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child:
              _SelectedBox(model: model, onTap: model.closeFilterFromDesktop),
        ),
        _SpacerFilterSelected(model: model),
        _spacer,
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              //USER INFO
              _HeaderUserFilters(),
              _spacer,
              _UserInfoFilters(
                  model: model, onTap: model.submitFilterFromDesktop),
              _spacer,
              //CRYPTOS
              _HeaderCryptoFilters(),
              _spacer,
              _CryptoFilter(
                model: model,
                onTap: model.submitDialogFilterFromDesktop,
              ),
              _spacer,
              //PAYMENT
              _HeaderPaymentFilters(),
              _spacer,
              _PaymentFilter(
                  model: model, onTap: model.submitDialogFilterFromDesktop),
            ],
          ),
        ),
      ],
    );
  }
}
