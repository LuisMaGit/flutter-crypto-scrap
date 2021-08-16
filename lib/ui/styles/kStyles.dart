import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//COLORS APP
const kOrange = Color(0xFFE84118);
const kBlue = Color(0xFF18BFE8);
const kBlack = Color(0xFF212121);
const kBlackDarker = Color(0xFF000000);
const kWhite = Color(0xFFffffff);
const kWhiteDarker = Color(0xFFEAEAED);
const kGrayDarker = Color(0xFF718093);
const kGray = Color(0XFF7f8fA6);

//COLORS CRYPTO
const kColorBtc = Color(0XFFE3B12A);
const kColorEth = Color(0XFF8893B5);
const kColorLtc = Color(0XFF005DA0);
const kColorDoge = Color(0XFFC5A021);
const kColorAda = Color(0XFF0099DE);
const kColorXmr = Color(0XFFE06B1A);
const kColorDash = Color(0XFF5173B9);
const kColorXrp = Color(0XFF7F99EA);
const kColorUsdt = Color(0XFF50AF95);
const kColorTrx = Color(0XFFFE0618);
const kColorDai = Color(0XFFF4B731);
const kColorPayeer = Color(0XFF0099DE);

//CONSTS
const kButtonsBorderRadius = 20.00;
const kAppBarHeight = 50.00;

//SHADOWS
List<BoxShadow> getShadow(BuildContext context) {
  return <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 1.0,
        spreadRadius: -1.0,
        color: Theme.of(context).colorScheme.onBackground),
    BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 1.0,
        spreadRadius: 0.0,
        color: Color(0x24000000)),
    BoxShadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 3.0,
      spreadRadius: 0.0,
      color: Color(0x1F000000),
    ),
  ];
}

//DIVIDER
Divider getDivider(BuildContext context) {
  return Divider(
    height: 0,
    color: Theme.of(context).colorScheme.secondaryVariant,
    thickness: 1,
  );
}
