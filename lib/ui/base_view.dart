import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrap/locator/locator.dart';
import 'package:scrap/ui/base_vm.dart';

class BaseView<T extends BaseVM> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;

  final Function(T viewModel)? initViewModel;
  final Function(T viewModel)? disponse;
  final bool disposeVM;

  final Widget? notRebuild;

  const BaseView({
    required this.builder,
    this.initViewModel,
    this.notRebuild,
    this.disponse,
    this.disposeVM = true,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseVM> extends State<BaseView<T>> {
  T viewModel = locator<T>();

  @override
  void initState() {
    super.initState();
    if (widget.initViewModel != null) widget.initViewModel!(viewModel);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.disponse != null) widget.disponse!(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.disposeVM) {
      return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<T>(
          child: widget.notRebuild,
          builder: widget.builder,
        ),
      );
    }

    return ChangeNotifierProvider<T>(
      create: (context) => viewModel,
      child: Consumer<T>(
        child: widget.notRebuild,
        builder: widget.builder,
      ),
    );
  }
}
