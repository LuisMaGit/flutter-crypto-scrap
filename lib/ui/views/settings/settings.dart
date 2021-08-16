import 'package:flutter/material.dart';
import 'package:scrap/generated/l10n.dart';
import 'package:scrap/ui/base_view.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/views/settings/settings_vm.dart';
import 'package:scrap/ui/widgets/app_bars.dart';
import 'package:scrap/ui/widgets/crypto_buttons.dart';
import 'package:scrap/ui/widgets/crypto_texts.dart';
import 'package:scrap/ui/widgets/fractionally_page_wrapper.dart';
import 'package:scrap/ui/widgets/modal_related/modal_selector.dart';
import 'package:scrap/utils/language_helper.dart';

const _iconSize = 36.0;
const _paddingCard = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12);

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      appBar: SimpleAppBar(title: lang.vSettingsTitle),
      body: Align(
        alignment: Alignment.topCenter,
        child: FractionallyPageWrapperBuilder(
          builder: (context, remainingW) {
            return BaseView<SettingsVM>(
              builder: (context, model, _) {
                void _showLanguageModal() {
                  late List<Column> languagesButtons = [];

                  languagesData.forEach((l) {
                    languagesButtons.add(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CryptoTextButton(
                              onTap: () {
                                S.load(Locale(l.code, l.countryCode));
                                model.changeLang(l.codeCountryCode);
                              },
                              text: l.name,
                              colorText: l.codeCountryCode ==
                                      model.selectedCodeCountryCodeLang
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  });

                  showDialog(
                      context: context,
                      builder: (context) => ModalSelector(
                            title: lang.vSettingsLanguages,
                            children: languagesButtons,
                            paddingHBody: 8,
                          ));
                }

                return ListView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    //THEME
                    DecoratedBox(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius:
                                BorderRadius.circular(kButtonsBorderRadius)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16.0),
                          child: Row(children: [
                            _Icon(icon: Icons.brightness_medium),
                            const SizedBox(width: 16),
                            SizedBox(
                                width: remainingW - 158,
                                child: CryptoText.b1(lang.vSettingsDarkMode,
                                    maxLines: 2)),
                            const SizedBox(width: 4),
                            SizedBox(
                                width: 60,
                                child: Switch(
                                    activeColor:
                                        Theme.of(context).colorScheme.primary,
                                    value: model.isDarkMode,
                                    onChanged: (_) => model.changeTheme())),
                          ]),
                        )),
                    const SizedBox(height: 20),
                    //Language
                    CryptoChildButton(
                        onTap: _showLanguageModal,
                        child: Padding(
                            padding: _paddingCard,
                            child: Row(
                              children: [
                                _Icon(icon: Icons.language_outlined),
                                const SizedBox(width: 16),
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: remainingW - 84)),
                                CryptoText.b1(lang.vSettingsLanguage)
                              ],
                            ))),
                    const SizedBox(height: 20),
                    //Version
                    Container(
                        padding: _paddingCard,
                        alignment: Alignment.bottomCenter,
                        child: CryptoText.b2(lang.vSettingsVersion))
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  const _Icon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon,
        size: _iconSize, color: Theme.of(context).colorScheme.secondaryVariant);
  }
}
