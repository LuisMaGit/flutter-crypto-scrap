import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/router/routes.dart';
import 'package:scrap/ui/base_view.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/views/home/home_vm.dart';
import 'package:scrap/ui/widgets/app_bars.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/fractionally_page_wrapper.dart';
import 'package:scrap/ui/widgets/offers_sections.dart';
import 'package:scrap/ui/widgets/screen_type_layout_helper.dart';
import 'package:scrap/ui/widgets/switcher.dart';
import 'package:scrap/utils/enums.dart';
import 'package:scrap/ui/views/home/filter_home/filter_home.dart';
part 'home_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNull(),
      body: BaseView<HomeVM>(
        initViewModel: (model) async {
          model.initHomeVM(startAnimation: fowardAnimation);

          _curvedAnimation.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            }
          });
        },
        builder: (context, model, _) {
          return ScreenTypeLayoutHelper(
            desktop: _DesktopView(animation: _curvedAnimation),
            mobile: _MobileView(animation: _curvedAnimation),
          );
        },
      ),
    );
  }
}

class _DesktopAppBar extends StatelessWidget {
  const _DesktopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: getShadow(context),
        color: Theme.of(context).colorScheme.background,
      ),
      child: FractionallyPageWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: CryptoTextLogo(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Switcher(),
                Row(
                  children: [
                    const _SettingsButtons(),
                    const SizedBox(width: 16),
                    const _TrackerButton(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _DesktopView extends StatelessWidget {
  final Animation<double> animation;
  const _DesktopView({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //APPBAR
        _DesktopAppBar(),
        //LIST + FILTER
        Expanded(
          child: FadeTransition(
            opacity: animation,
            child: Row(
              children: [
                //LIST
                Expanded(
                    flex: 2,
                    child: FractionallyPageWrapper(
                      factor: .9,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          return _SalesCard(index: index);
                        },
                      ),
                    )),
                //FILTER
                Expanded(flex: 1, child: FilterHomeDesktop())
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileView extends StatelessWidget {
  final Animation<double> animation;
  const _MobileView({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
            pinned: true, floating: true, delegate: _MobileAppBar()),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 20),
          sliver: SliverFadeTransition(
            opacity: animation,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    FractionallyPageWrapper(child: _SalesCard(index: index)),
                childCount: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileAppBar extends SliverPersistentHeaderDelegate {
  const _MobileAppBar();

  static const minHeightExtent = 55.0;

  @override
  double get maxExtent => 125;

  @override
  double get minExtent => minHeightExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final model = Provider.of<HomeVM>(context);
    final lang = S.of(context);
    final reachTop = shrinkOffset < minHeightExtent;
    final double h =
        minHeightExtent - (reachTop ? shrinkOffset : minHeightExtent);
    final factorByHeight = pow(h / minHeightExtent, 4).toDouble();

    void goToFilter() {
      Navigator.of(context)
          .pushNamed(Routes.FilterHomeMobile, arguments: model);
    }

    return Column(
      children: [
        //TOP
        Container(
          height: h,
          color: Theme.of(context).colorScheme.background,
          child: FractionallyPageWrapperBuilder(
            maxW: double.infinity,
            builder: (context, remainingW) {
              return AnimatedOpacity(
                  opacity: factorByHeight,
                  duration: Duration(microseconds: 500),
                  child: Row(
                    children: [
                      SizedBox(width: remainingW - 92, child: CryptoTextLogo()),
                      const _SettingsButtons(),
                      const SizedBox(width: 16),
                      const _TrackerButton(),
                    ],
                  ));
            },
          ),
        ),
        //BOTTOM
        Container(
          width: double.infinity,
          height: minHeightExtent,
          decoration: BoxDecoration(
              boxShadow: !reachTop ? getShadow(context) : null,
              color: Theme.of(context).colorScheme.background),
          alignment: Alignment.center,
          child: FractionallyPageWrapper(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: const _Switcher(),
                ),
                SizedBox(
                    height: 35,
                    width: 65,
                    child: model.hasFilter
                        ? CryptoChildButton(
                            child: Icon(Icons.filter_alt_rounded,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant),
                            onTap: goToFilter,
                          )
                        : CryptoRoundedButton(
                            onTap: goToFilter,
                            text: lang.vHomeFilter,
                          ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
