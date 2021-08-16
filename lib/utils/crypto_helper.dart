import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/utils/assets_helpers.dart';
import 'package:scrap/utils/enums.dart';

class CryptoHelperModel {
  final String name;
  final Color color;
  final String picture;

  const CryptoHelperModel({
    required this.name,
    required this.color,
    required this.picture,
  });
}

const Map<CryptoCode, CryptoHelperModel> cryptoDataHelper = {
  CryptoCode.BTC: const CryptoHelperModel(
    name: 'Bitcoin',
    color: kColorBtc,
    picture: CryptoLogos.btc,
  ),
  CryptoCode.ETH: const CryptoHelperModel(
    name: 'Ethereum',
    color: kColorEth,
    picture: CryptoLogos.eth,
  ),
  CryptoCode.LTC: const CryptoHelperModel(
      name: 'Litecoin', color: kColorLtc, picture: CryptoLogos.ltc),
  CryptoCode.DOGE: CryptoHelperModel(
    name: 'Doge',
    color: kColorDoge,
    picture: CryptoLogos.doge,
  ),
  CryptoCode.USDT: const CryptoHelperModel(
    name: 'USDT',
    color: kColorUsdt,
    picture: CryptoLogos.usdt,
  ),
  CryptoCode.USDTT: const CryptoHelperModel(
      name: 'USDTT', color: kColorUsdt, picture: CryptoLogos.usdtt),
  CryptoCode.TRX: CryptoHelperModel(
    name: 'Tron',
    color: kColorTrx,
    picture: CryptoLogos.trx,
  ),
  CryptoCode.DAI: const CryptoHelperModel(
    name: 'DAI',
    color: kColorDai,
    picture: CryptoLogos.dai,
  ),
  CryptoCode.RUBP: const CryptoHelperModel(
    name: 'Rublo Payeer',
    color: kColorPayeer,
    picture: CryptoLogos.rubp,
  ),
  CryptoCode.EURP: const CryptoHelperModel(
    name: 'Euro Payeer',
    color: kColorPayeer,
    picture: CryptoLogos.erup,
  ),
  CryptoCode.USDP: const CryptoHelperModel(
    name: 'Usd Payeer',
    color: kColorPayeer,
    picture: CryptoLogos.usdp,
  ),
  CryptoCode.ADA: const CryptoHelperModel(
    name: 'Cardano',
    color: kColorAda,
    picture: CryptoLogos.ada,
  ),
  CryptoCode.XMR: const CryptoHelperModel(
    name: 'Monero',
    color: kColorXmr,
    picture: CryptoLogos.xmr,
  ),
  CryptoCode.DASH: const CryptoHelperModel(
    name: 'Dash',
    color: kColorDash,
    picture: CryptoLogos.dash,
  ),
  CryptoCode.XRP: const CryptoHelperModel(
    name: 'Ripple',
    color: kColorXrp,
    picture: CryptoLogos.xrp,
  ),
  CryptoCode.UNKNOW: const CryptoHelperModel(
    name: 'Unknow',
    color: Colors.red,
    picture: CryptoLogos.unk,
  ),
};
