import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/models/data/crypto_model.dart';
import 'package:scrap/ui/base_view.dart';
import 'package:scrap/ui/views/tracker/tracker_vm.dart';
import 'package:scrap/ui/widgets/app_bars.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/fractionally_page_wrapper.dart';
import 'package:scrap/ui/widgets/modal_related/dynamic_dialog_manager.dart';
import 'package:scrap/ui/widgets/graph.dart';
import 'package:scrap/ui/widgets/ripple_button.dart';
import 'package:scrap/utils/crypto_helper.dart';
import 'package:scrap/utils/enums.dart';
import 'package:scrap/utils/fiat_helper.dart';
import 'package:scrap/ui/widgets/modal_related/modal_selector.dart';

const _spacerV = SizedBox(height: 16);
const _spacerH = SizedBox(width: 12);
const _offsetScrollLine = 16.00;

abstract class _BindersTracker {
  //Bind CryptoModel -> Plots
  static List<Plot> bindPlotsFromCryptoModel(List<CryptoModel> cryptoModel) {
    return cryptoModel.map<Plot>((c) => Plot(c.time, c.price)).toList();
  }
}

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> with SingleTickerProviderStateMixin {
  late AnimationController _controllerYFactor;
  late CurvedAnimation _curveYAnimation;
  late Animation<double> _animationYFactor;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controllerYFactor =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationYFactor =
        Tween<double>(begin: 0, end: 1).animate(_controllerYFactor);
    _curveYAnimation =
        CurvedAnimation(curve: Curves.easeIn, parent: _animationYFactor);
  }

  Future<void> _startAnimation() async {
    await _controllerYFactor.forward();
  }

  Future<void> _reverseAnimation() async {
    await _controllerYFactor.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerYFactor.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    Future<FiatCode?> _showFiatDialog(FiatCode selected) async {
      return await showDialog(
          context: context,
          builder: (context) => ModalSelector(
              title: lang.vTrackerFiatSign,
              paddingHBody: 16,
              children: FiatCode.values.map((f) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(f);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CryptoText.b1(
                      fiatDataHelper[f]!.name,
                      color: selected == f
                          ? null
                          : Theme.of(context).colorScheme.secondaryVariant,
                    ),
                  ),
                );
              }).toList()));
    }

    return DynamicDialogManager(
      child: Scaffold(
        appBar: AppBarNull(),
        body: BaseView<TrackerVM>(
          initViewModel: (model) {
            _scrollController = ScrollController()
              ..addListener(() {
                if (_scrollController.offset >= _offsetScrollLine) {
                  model.handleShowLine(true);
                } else {
                  model.handleShowLine(false);
                }
              });

            model.initTrackerVM(
              startAnimation: _startAnimation,
              reverseAnimation: _reverseAnimation,
              showFiatDialog: _showFiatDialog,
            );
          },
          builder: (context, model, _) {
            final graphModel = GraphModel(
              prefixBigText: fiatDataHelper[model.fiatSelected]!.symbol,
              plots: [],
            );

            if (model.state == ViewState.Bussy) {
              final baseText =
                  'Loading ${cryptoDataHelper[model.cryptoSelected]!.name}...';
              return _Body(
                  disable: true,
                  scrollController: _scrollController,
                  graphModel: graphModel.copyWith(bigText: baseText));
            }
            if (model.state == ViewState.Iddle) {
              final plots = _BindersTracker.bindPlotsFromCryptoModel(
                  model.detailsSelected.cryptoData);
              final baseText = '1 ${model.strCryptoCodeSelected} ≈';
              return _Body(
                  curvedAnimation: _curveYAnimation,
                  scrollController: _scrollController,
                  graphModel:
                      graphModel.copyWith(plots: plots, baseText: baseText));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final GraphModel graphModel;
  final bool disable;
  final CurvedAnimation? curvedAnimation;
  final ScrollController scrollController;

  const _Body({
    Key? key,
    required this.graphModel,
    required this.scrollController,
    this.curvedAnimation,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _shortest = MediaQuery.of(context).size.shortestSide;
    final _model = Provider.of<TrackerVM>(context);
    final _lang = S.of(context);

    final date = {
      TimeSpan.Day: _lang.vTrackerDate1d,
      TimeSpan.Week: _lang.vTrackerDate1w,
      TimeSpan.TwoWeeks: _lang.vTrackerDate2w,
      TimeSpan.Month: _lang.vTrackerDate1m,
      TimeSpan.Year: _lang.vTrackerDate1y,
      TimeSpan.TwoYears: _lang.vTrackerDate2y,
      TimeSpan.FiveYears: _lang.vTrackerDate5y,
    };

    return Column(
      children: [
        const SizedBox(height: 10),
        //App Bar
        FractionallyPageWrapperBuilder(
          maxW: double.infinity,
          builder: (context, remainingW) => Row(
            children: [
              _spacerH,
              CryptoBackButton(),
              _spacerH,
              Container(
                width: remainingW - 150,
                alignment: Alignment.centerLeft,
                child: CryptoText.h1Cursive(
                    cryptoDataHelper[_model.cryptoSelected]!.name,
                    color: cryptoDataHelper[_model.cryptoSelected]!.color),
              ),
              CryptoChildButton(
                  onTap: disable ? () {} : _model.openFiatDialog,
                  child: Container(
                    width: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    alignment: Alignment.center,
                    child: CryptoText.h2(
                        fiatDataHelper[_model.fiatSelected]!.symbol),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        //Dates
        SizedBox(
          height: 40,
          child: FractionallyPageWrapper(
            maxW: _shortest,
            child: Row(
                children: [
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 10),
                    physics: BouncingScrollPhysics(),
                    children: TimeSpan.values.map((t) {
                      return Center(
                        child: GestureDetector(
                          onTap: disable ? () {} : () => _model.changeDate(t),
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: t == _model.timeSpanSelected
                                    ? cryptoDataHelper[_model.cryptoSelected]!
                                        .color
                                        .withOpacity(.5)
                                    : Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(14)),
                            child: CryptoText.b2(date[t] ?? ''),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                ],
              ),
          ),
        ),
        _spacerV,
        //Graph
        Container(
          height: _h * .3,
          constraints: BoxConstraints(
            minHeight: 200,
            maxHeight: 400,
            maxWidth: _shortest,
          ),
          child: AnimatedBuilder(
              animation: curvedAnimation ?? AlwaysStoppedAnimation(0),
              builder: (context, child) {
                return Graph(
                  yMoveFactor: curvedAnimation?.value ?? 0,
                  graphData: graphModel,
                  primaryColor: cryptoDataHelper[_model.cryptoSelected]!.color,
                  backGroundColor: Theme.of(context).canvasColor,
                  bigTextColor: Theme.of(context).colorScheme.primary,
                  cardColor: Theme.of(context).colorScheme.onBackground,
                  primaryTextStyle: Theme.of(context).textTheme.headline1,
                  secondaryTextStyle: Theme.of(context).textTheme.caption,
                );
              }),
        ),
        _spacerV,
        //Divider
        Visibility(
          visible: _model.showLine,
          child: Divider(
              color: Theme.of(context).colorScheme.secondaryVariant, height: 0),
        ),
        //Coins List
        Expanded(
            child: ListView.builder(
          controller: scrollController,
          itemCount: listCryptosToTrack.length,
          padding: const EdgeInsets.only(top: 16),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final cryptoCode = listCryptosToTrack[index];
            return Center(
              child: FractionallyPageWrapperBuilder(
                maxW: _shortest,
                builder: (context, remaingW) => _CryptoCard(
                  width: remaingW,
                  disable: disable,
                  handleChange: _model.changeCrypto,
                  cryptoCode: cryptoCode,
                  colorCrypto: cryptoDataHelper[_model.cryptoSelected]!.color,
                  decrease: _model.detailsOf(cryptoCode).percentage.isNegative,
                  codeStr: _model.strCodeOf(cryptoCode),
                  percentage: _model.detailsOf(cryptoCode).percentageStr,
                  fiat: fiatDataHelper[_model.fiatSelected]!.symbol,
                  price: _model.detailsOf(cryptoCode).lastStr,
                  plots: _BindersTracker.bindPlotsFromCryptoModel(
                      _model.detailsOf(cryptoCode).cryptoData),
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}

class _CryptoCard extends StatelessWidget {
  final CryptoCode cryptoCode;
  final Color colorCrypto;
  final String codeStr;
  final String percentage;
  final bool decrease;
  final String price;
  final String fiat;
  final List<Plot> plots;
  final double width;
  final bool disable;
  final void Function(CryptoCode c) handleChange;

  const _CryptoCard({
    Key? key,
    required this.cryptoCode,
    required this.colorCrypto,
    required this.decrease,
    required this.codeStr,
    required this.price,
    required this.plots,
    required this.fiat,
    required this.width,
    required this.handleChange,
    this.disable = false,
    this.percentage = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String arrow() => decrease ? '↓ ' : '↑ ';
    Color colorPercentage = decrease ? Colors.redAccent : Colors.green;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: RippleButton(
        onTap: disable ? () {} : () => handleChange(cryptoCode),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _spacerH,
            //LOGO + NAME + CODE
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 80),
              child: Column(
                children: [
                  //LOGO
                  SvgPicture.asset(cryptoDataHelper[cryptoCode]!.picture,
                      width: 80, height: 80),
                  //NAME
                  CryptoText.b1(
                    cryptoDataHelper[cryptoCode]!.name,
                    color: cryptoDataHelper[cryptoCode]!.color,
                  ),
                  //CODE
                  CryptoText.caption(
                    codeStr,
                    color: cryptoDataHelper[cryptoCode]!.color,
                  ),
                ],
              ),
            ),
            //PRICE
            _spacerH,
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  width: width - 216,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CryptoText.h2('$fiat $price', maxLines: 2),
                      //PERCENTAGE
                      RichText(
                          maxLines: 1,
                          text: TextSpan(children: [
                            TextSpan(
                                text: arrow(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: colorPercentage)),
                            TextSpan(
                                text: '$percentage%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: colorPercentage)),
                          ])),
                    ],
                  )),
            ),
            //Graph
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 100, maxHeight: 40),
                child: Graph(
                    yMoveFactor: 1,
                    graphData:
                        GraphModel(typeCard: TypeGraph.preview, plots: plots),
                    primaryColor: colorPercentage,
                    backGroundColor: Theme.of(context).canvasColor,
                    bigTextColor: Theme.of(context).colorScheme.primary,
                    cardColor: Theme.of(context).colorScheme.onBackground,
                    primaryTextStyle: Theme.of(context).textTheme.headline1,
                    secondaryTextStyle: Theme.of(context).textTheme.caption),
              ),
            ),
            _spacerH,
          ],
        ),
      ),
    );
  }
}
