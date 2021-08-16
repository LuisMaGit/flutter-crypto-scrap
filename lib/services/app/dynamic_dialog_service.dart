import 'dart:async';

import 'package:scrap/utils/enums.dart';

class DynamicDialogService {
  late Function(DynamicDialogType type, {String? text}) _showDialog;
  late Completer<bool> _dialogCompleter;

  void registerShowDialog(Function(DynamicDialogType type, {String? text}) showDialog) {
    _showDialog = showDialog;
  }

  Future showDialog(DynamicDialogType type, {String? text}) {
    _dialogCompleter = Completer<bool>();
    _showDialog(type, text: text);
    return _dialogCompleter.future;
  }

  void dialogComplete(bool response) {
    _dialogCompleter.complete(response);
  }
}
