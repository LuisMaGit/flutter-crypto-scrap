import 'package:flutter/material.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/dynamic_dialog_service.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/modal_related/dialog_wrapper.dart';
import 'package:scrap/utils/enums.dart';

class DynamicDialogManager extends StatefulWidget {
  final Widget child;

  const DynamicDialogManager({Key? key, required this.child}) : super(key: key);

  @override
  _DynamicDialogManagerState createState() => _DynamicDialogManagerState();
}

class _DynamicDialogManagerState extends State<DynamicDialogManager> {
  final _dynamicDialogService = locator<DynamicDialogService>();

  @override
  void initState() {
    super.initState();
    _dynamicDialogService.registerShowDialog(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _DialogContentLayout _contentDialog(DynamicDialogType type, {String? text}) {
    final _lang = S.of(context);
    switch (type) {
      case DynamicDialogType.SimpleError:
        return _DialogContentLayout(
          icon: Icon(Icons.error, color: Colors.redAccent),
          header: _lang.dialogSimpleErrorHeader,
          body: _lang.dialogTryAgainButton,
          buttons: _twoButtons(),
        );
      default:
        return _DialogContentLayout();
    }
  }

  Row _twoButtons({String? ok, String? cancel}) {
    final _lang = S.of(context);
    final _ok = ok == null ? _lang.dialogOk : ok;
    final _cancel = cancel == null ? _lang.dialogCancel : cancel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Container(
                width: 80,
                alignment: Alignment.center,
                child: CryptoTextButton(
                  onTap: () {
                    _dynamicDialogService.dialogComplete(true);
                    Navigator.of(context).pop();
                  },
                  text: _ok,
                ))),
        SizedBox(width: 10),
        Expanded(
            flex: 1,
            child: Container(
                width: 80,
                alignment: Alignment.center,
                child: CryptoTextButton(
                  onTap: () {
                    _dynamicDialogService.dialogComplete(false);
                    Navigator.of(context).pop();
                  },
                  text: _cancel,
                ))),
      ],
    );
  }

  Container _singleButton({String? ok}) {
    final _lang = S.of(context);
    final _ok = ok == null ? _lang.dialogOk : ok;
    return Container(
      width: 180,
      alignment: Alignment.center,
      child: CryptoTextButton(
        onTap: () {
          _dynamicDialogService.dialogComplete(true);
          Navigator.of(context).pop();
        },
        text: _ok,
      ),
    );
  }

  Future _showDialog(DynamicDialogType type, {String? text}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                _dynamicDialogService.dialogComplete(false);
                Navigator.of(context).pop();
                return true;
              },
              child: DialogWrapper(child: _contentDialog(type, text: text)));
        });
  }
}

class _DialogContentLayout extends StatelessWidget {
  final Icon? icon;
  final String? header;
  final TextStyle? headerStyle;
  final String? body;
  final TextStyle? bodyStyle;
  final Widget? buttons;

  const _DialogContentLayout({
    Key? key,
    this.icon,
    this.header,
    this.headerStyle,
    this.body,
    this.buttons,
    this.bodyStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Icon
        icon ?? SizedBox(),
        SizedBox(height: 10),
        //Header
        header == null
            ? SizedBox()
            : Text(header!,
                textAlign: TextAlign.center,
                style: headerStyle ?? Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 5),
        //Body
        body == null
            ? SizedBox()
            : Text(body!,
                textAlign: TextAlign.center,
                style: bodyStyle ?? Theme.of(context).textTheme.bodyText2),
        SizedBox(height: 20),
        //Buttons
        buttons ?? SizedBox(),
      ],
    );
  }
}
