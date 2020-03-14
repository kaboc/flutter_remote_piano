import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:flutter_remote_piano/localizations/l10n/messages_all.dart';
import 'package:flutter_remote_piano/localizations/messages.dart';

const supportedLanguages = ['en', 'ja', 'zh'];
const supportedLocales = [
  Locale('en'),
  Locale('ja'),
  Locale('zh'),
  Locale('zh', 'CN'),
  Locale('zh', 'HK'),
  Locale('zh', 'TW'),
];

class AppLocalizations with LocalizationMessages {
  static Future<AppLocalizations> load(Locale locale) {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }
}

AppLocalizations l(BuildContext context) {
  return Localizations.of<AppLocalizations>(context, AppLocalizations);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      supportedLanguages.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
