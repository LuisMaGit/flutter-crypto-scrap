import 'package:flutter/material.dart';
import 'package:scrap/ui/base_view.dart';
import 'package:scrap/ui/views/startup/startup_vm.dart';
import 'package:scrap/ui/widgets/loader.dart';
import 'package:scrap/utils/enums.dart';

class Startup extends StatelessWidget {
  const Startup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<StartupVM>(
        initViewModel: (model)=> model.initStartup(),
        builder: (context, model, _) {
          if (model.state == ViewState.Bussy) {
            return Loader.logo();
          }
          return SizedBox();
        },
      ),
    );
  }
}
