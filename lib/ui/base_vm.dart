import 'package:flutter/foundation.dart';
import 'package:scrap/utils/enums.dart';

class BaseVM extends ChangeNotifier {
  ViewState _state = ViewState.Bussy;
  get state => _state;

  //Base event
  set setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  bool _disposed = false;
  bool get disposed => _disposed;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}
