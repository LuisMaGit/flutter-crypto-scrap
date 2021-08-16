// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ok`
  String get dialogOk {
    return Intl.message(
      'Ok',
      name: 'dialogOk',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get dialogCancel {
    return Intl.message(
      'Cancel',
      name: 'dialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get dialogSimpleErrorHeader {
    return Intl.message(
      'Something went wrong',
      name: 'dialogSimpleErrorHeader',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get dialogTryAgainButton {
    return Intl.message(
      'Try again',
      name: 'dialogTryAgainButton',
      desc: '',
      args: [],
    );
  }

  /// `Buying`
  String get vHomeBuying {
    return Intl.message(
      'Buying',
      name: 'vHomeBuying',
      desc: '',
      args: [],
    );
  }

  /// `Selling`
  String get vHomeSelling {
    return Intl.message(
      'Selling',
      name: 'vHomeSelling',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get vHomeFilter {
    return Intl.message(
      'Filter',
      name: 'vHomeFilter',
      desc: '',
      args: [],
    );
  }

  /// `Inverval`
  String get vHomeInverterval {
    return Intl.message(
      'Inverval',
      name: 'vHomeInverterval',
      desc: '',
      args: [],
    );
  }

  /// `Sales Value`
  String get vHomeSalesValue {
    return Intl.message(
      'Sales Value',
      name: 'vHomeSalesValue',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get vHomePaymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'vHomePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `1D`
  String get vTrackerDate1d {
    return Intl.message(
      '1D',
      name: 'vTrackerDate1d',
      desc: '',
      args: [],
    );
  }

  /// `1W`
  String get vTrackerDate1w {
    return Intl.message(
      '1W',
      name: 'vTrackerDate1w',
      desc: '',
      args: [],
    );
  }

  /// `2W`
  String get vTrackerDate2w {
    return Intl.message(
      '2W',
      name: 'vTrackerDate2w',
      desc: '',
      args: [],
    );
  }

  /// `1M`
  String get vTrackerDate1m {
    return Intl.message(
      '1M',
      name: 'vTrackerDate1m',
      desc: '',
      args: [],
    );
  }

  /// `1Y`
  String get vTrackerDate1y {
    return Intl.message(
      '1Y',
      name: 'vTrackerDate1y',
      desc: '',
      args: [],
    );
  }

  /// `2Y`
  String get vTrackerDate2y {
    return Intl.message(
      '2Y',
      name: 'vTrackerDate2y',
      desc: '',
      args: [],
    );
  }

  /// `5Y`
  String get vTrackerDate5y {
    return Intl.message(
      '5Y',
      name: 'vTrackerDate5y',
      desc: '',
      args: [],
    );
  }

  /// `Convert to:`
  String get vTrackerFiatSign {
    return Intl.message(
      'Convert to:',
      name: 'vTrackerFiatSign',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get vOffersInformation {
    return Intl.message(
      'Information',
      name: 'vOffersInformation',
      desc: '',
      args: [],
    );
  }

  /// `Register date: `
  String get vOffersRegisterDate {
    return Intl.message(
      'Register date: ',
      name: 'vOffersRegisterDate',
      desc: '',
      args: [],
    );
  }

  /// `Votes of confidence: `
  String get vOffersVotesConfidence {
    return Intl.message(
      'Votes of confidence: ',
      name: 'vOffersVotesConfidence',
      desc: '',
      args: [],
    );
  }

  /// `Users who ignore him: `
  String get vOffersUserIgnore {
    return Intl.message(
      'Users who ignore him: ',
      name: 'vOffersUserIgnore',
      desc: '',
      args: [],
    );
  }

  /// `Offers: `
  String get vOffersUserOffers {
    return Intl.message(
      'Offers: ',
      name: 'vOffersUserOffers',
      desc: '',
      args: [],
    );
  }

  /// `Selling`
  String get vOffersUserOffersSelling {
    return Intl.message(
      'Selling',
      name: 'vOffersUserOffersSelling',
      desc: '',
      args: [],
    );
  }

  /// `Buying`
  String get vOffersUserOffersBuying {
    return Intl.message(
      'Buying',
      name: 'vOffersUserOffersBuying',
      desc: '',
      args: [],
    );
  }

  /// `Sellers' opinion: `
  String get vOffersSalesCalifaction {
    return Intl.message(
      'Sellers\' opinion: ',
      name: 'vOffersSalesCalifaction',
      desc: '',
      args: [],
    );
  }

  /// `Purchase rating: `
  String get vOffersBuyCalifaction {
    return Intl.message(
      'Purchase rating: ',
      name: 'vOffersBuyCalifaction',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get vOffersShare {
    return Intl.message(
      'Share',
      name: 'vOffersShare',
      desc: '',
      args: [],
    );
  }

  /// `Transact`
  String get vOffersTransac {
    return Intl.message(
      'Transact',
      name: 'vOffersTransac',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get vSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'vSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get vSettingsLanguage {
    return Intl.message(
      'Language',
      name: 'vSettingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get vSettingsLanguages {
    return Intl.message(
      'Languages',
      name: 'vSettingsLanguages',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get vSettingsDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'vSettingsDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get vSettingsVersion {
    return Intl.message(
      'Version',
      name: 'vSettingsVersion',
      desc: '',
      args: [],
    );
  }

  /// `Filter sales`
  String get vFilterAppBarFilterSale {
    return Intl.message(
      'Filter sales',
      name: 'vFilterAppBarFilterSale',
      desc: '',
      args: [],
    );
  }

  /// `Filter buys`
  String get vFilterAppBarFilterBuys {
    return Intl.message(
      'Filter buys',
      name: 'vFilterAppBarFilterBuys',
      desc: '',
      args: [],
    );
  }

  /// `Sales filtered by:`
  String get vFilterSalesResult {
    return Intl.message(
      'Sales filtered by:',
      name: 'vFilterSalesResult',
      desc: '',
      args: [],
    );
  }

  /// `Buys filtered by:`
  String get vFilterBuysResult {
    return Intl.message(
      'Buys filtered by:',
      name: 'vFilterBuysResult',
      desc: '',
      args: [],
    );
  }

  /// `User info`
  String get vFilterUserInfo {
    return Intl.message(
      'User info',
      name: 'vFilterUserInfo',
      desc: '',
      args: [],
    );
  }

  /// `Best votes of confidence`
  String get vFilterBestVotesConfidence {
    return Intl.message(
      'Best votes of confidence',
      name: 'vFilterBestVotesConfidence',
      desc: '',
      args: [],
    );
  }

  /// `Best sellers' opinions`
  String get vFilterBestSalersOpinion {
    return Intl.message(
      'Best sellers\' opinions',
      name: 'vFilterBestSalersOpinion',
      desc: '',
      args: [],
    );
  }

  /// `Best buyres' opinions`
  String get vFilterBestBuyersOpinion {
    return Intl.message(
      'Best buyres\' opinions',
      name: 'vFilterBestBuyersOpinion',
      desc: '',
      args: [],
    );
  }

  /// `Available cryptos`
  String get vFilterCryptos {
    return Intl.message(
      'Available cryptos',
      name: 'vFilterCryptos',
      desc: '',
      args: [],
    );
  }

  /// `Available payment methods`
  String get vFilterPayment {
    return Intl.message(
      'Available payment methods',
      name: 'vFilterPayment',
      desc: '',
      args: [],
    );
  }

  /// `Select...`
  String get vFilterSelect {
    return Intl.message(
      'Select...',
      name: 'vFilterSelect',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
