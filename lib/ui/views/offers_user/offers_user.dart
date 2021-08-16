import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/ui/base_view.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/views/offers_user/offers_user_vm.dart';
import 'package:scrap/ui/widgets/app_bars.dart';
import 'package:scrap/ui/widgets/avatar.dart';
import 'package:scrap/ui/widgets/buttons_offers_section.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/fractionally_page_wrapper.dart';
import 'package:scrap/ui/widgets/kyc.dart';
import 'package:scrap/ui/widgets/offers_sections.dart';
import 'package:scrap/ui/widgets/screen_type_layout_helper.dart';
import 'package:scrap/ui/widgets/starts_rating.dart';
import 'package:scrap/ui/widgets/switcher.dart';
import 'package:scrap/utils/enums.dart';

import '../../widgets/app_bars.dart';
import '../../widgets/avatar.dart';
import '../../widgets/fractionally_page_wrapper.dart';
import '../../widgets/kyc.dart';
import 'offers_user_vm.dart';
part 'offers_widgets.dart';

const _bigSpacer = const SizedBox(height: 18);
const _mediumSpacer = const SizedBox(height: 8);

class OffersUser extends StatefulWidget {
  const OffersUser({Key? key}) : super(key: key);

  @override
  _OffersUserState createState() => _OffersUserState();
}

class _OffersUserState extends State<OffersUser>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );
  late final _animation =
      Tween<double>(begin: 1, end: 0).animate(_animationController);

  late final _curvedAnimation =
      CurvedAnimation(parent: _animation, curve: Curves.easeIn);

  Future<void> fowardAnimation() async {
    await _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OffersUserVM>(
      initViewModel: (model) async {
        model.initOffersUserVM(startAnimation: fowardAnimation);

        _curvedAnimation.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        });
      },
      builder: (context, model, _) => ScreenTypeLayoutHelper(
        mobile: _MobileView(animation: _curvedAnimation),
        desktop: _DesktopView(animation: _curvedAnimation),
      ),
    );
  }
}

class _MobileView extends StatelessWidget {
  final Animation<double> animation;
  const _MobileView({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _AppBarMobile(),
        body: Center(
          child: FractionallyPageWrapper(
            maxW: 900,
            child: CustomScrollView(
              slivers: [
                //INFO + SWITCHER
                SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: _InformationSection(),
                    ),
                    _SwitcherSection(),
                  ],
                )),

                //OFFERS
                SliverFadeTransition(
                  opacity: animation,
                  sliver: SliverPadding(
                    padding: const EdgeInsets.only(top: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _CardOffers(index: index),
                        childCount: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class _DesktopView extends StatelessWidget {
  final Animation<double> animation;
  const _DesktopView({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
          title:
              'Officia dolor cupidatat deserunt proident pariatur tempor eiusmod adipisicing voluptate.'),
      body: Row(
        children: [
          //USER INFO
          Expanded(
            flex: 1,
            child: Center(
                child: Column(
              children: [
                _bigSpacer,
                Avatar(
                  name: 'O',
                  picture: null,
                  radius: 80,
                ),
                _bigSpacer,
                const Center(child: Kyc(active: false)),
                const Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: _InformationSection(),
                ),
              ],
            )),
          ),
          //SALES
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _bigSpacer,
                _SwitcherSection(),
                _mediumSpacer,
                Expanded(
                  child: FadeTransition(
                    opacity: animation,
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                      itemBuilder: (context, index) {
                        return _CardOffers(index: index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
