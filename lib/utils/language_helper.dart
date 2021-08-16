class LanguageHelperModel {
  final String name;
  final String code;
  final String countryCode;
  final String codeCountryCode;

  const LanguageHelperModel({
    required this.name,
    required this.code,
    required this.countryCode,
    required this.codeCountryCode,
  });
}

const List<LanguageHelperModel> languagesData = [
  const LanguageHelperModel(
      name: 'English', code: 'en', countryCode: 'US', codeCountryCode: 'en_US'),
  const LanguageHelperModel(
      name: 'Español', code: 'es', countryCode: 'ES', codeCountryCode: 'es_ES'),
];
