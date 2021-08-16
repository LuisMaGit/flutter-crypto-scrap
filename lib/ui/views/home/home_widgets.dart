part of 'home.dart';

class _TrackerButton extends StatelessWidget {
  const _TrackerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return CryptoChildButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
        child: Icon(Icons.settings, color: Theme.of(context).primaryColor),
      ),
      onTap: model.goToSettngs,
    );
  }
}

class _SettingsButtons extends StatelessWidget {
  const _SettingsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return CryptoChildButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
        child: Icon(Icons.timeline_outlined,
            color: Theme.of(context).primaryColor),
      ),
      onTap: model.goToTracker,
    );
  }
}

class _Switcher extends StatelessWidget {
  const _Switcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final model = Provider.of<HomeVM>(context);
    return Switcher(
      backgroundColor: model.theme == ThemeModeApp.Dark
          ? Theme.of(context).colorScheme.onBackground
          : Theme.of(context).colorScheme.onPrimary,
      buttonColor: Theme.of(context).colorScheme.primary,
      text1: '\t${lang.vHomeSelling}\t',
      text2: '\t${lang.vHomeBuying}\t',
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: kWhite),
      onChanged: model.changeScreen,
    );
  }
}

class _SalesCard extends StatelessWidget {
  final int index;
  const _SalesCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return SalersCard(
      key: ValueKey<bool>(model.selling),
      idx: index,
      cryptoCode: CryptoCode.BTC,
      name: 'Id cupidatat ${model.selling}',
      rating: 3,
      confidence: '10',
      ingnore: '20',
      interval: 'Proident officia d',
      payment: 'Elit est reprehenderit adipisici',
      salesValue: 'Cupidatat labore ea ad labore ',
      goToUserOffers: model.goToUserOffers,
    );
  }
}
