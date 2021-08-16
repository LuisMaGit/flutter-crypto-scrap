import 'package:flutter/material.dart';
import 'package:scrap/utils/enums.dart';

//Provides architecture for every screen type
class ScreenTypeLayoutHelper extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ScreenTypeLayoutHelper(
      {required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return _ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          // device is Tablet
          if (tablet != null) return tablet!; // and provided ui
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          // device is Desktop
          if (desktop != null) return desktop!; // and provided ui
        }

        return mobile; // default mobile
      },
    );
  }
}

class _SizingInformationModel {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  _SizingInformationModel({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DevicesSreenType: ${this.deviceScreenType}\n' +
        'ScreenSize: ${this.screenSize}\n' +
        'LocalWidgetSize: ${this.localWidgetSize}\n';
  }
}

//These Build Methode give the sizing information of the scrren and
//widget that build
class _ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
          BuildContext context, _SizingInformationModel sizingInformationModel)
      builder;

  _ResponsiveBuilder({required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        //MediaQuery Widgets that wraps
        var mediaQuery = MediaQuery.of(context);
        //Info
        _SizingInformationModel sizingInFormationModel =
            _SizingInformationModel(
          deviceScreenType: _getDeviceScreenType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize:
              Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
        );

        return builder(context, sizingInFormationModel);
      },
    );
  }

  //Get Type of Screen
  DeviceScreenType _getDeviceScreenType(MediaQueryData mediaQuery) {
    double deviceWidth = mediaQuery.size.width;


    //Desktop
    if (deviceWidth > 950) {
      return DeviceScreenType.Desktop;
    }

    //Tablet
    if (deviceWidth > 600) {
      return DeviceScreenType.Tablet;
    }

    //Movile Default
    return DeviceScreenType.Mobile;
  }
}
