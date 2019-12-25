import 'package:intl/intl.dart';

mixin LocalizationMessages {
  String get appTitle => Intl.message(
        'Remote Piano',
        name: 'appTitle',
      );

  String get hostTitle => Intl.message(
        'Hostname or IP',
        name: 'hostTitle',
      );

  String get port => Intl.message(
        'Port',
        name: 'port',
      );

  String get placeholderPrefix => Intl.message(
        'e.g.',
        name: 'placeholderPrefix',
      );

  String get cancel => Intl.message(
        'CANCEL',
        name: 'cancel',
      );

  String get connect => Intl.message(
        'CONNECT',
        name: 'connect',
      );

  String get errorTitle => Intl.message(
        'ERROR',
        name: 'errorTitle',
      );

  String get validationError => Intl.message(
        'Please enter information correctly.',
        name: 'validationError',
      );

  String get platformError => Intl.message(
        'Remote operation is not supported\non this platform.',
        name: 'platformError',
      );

  String get connectionError => Intl.message(
        'Connection failed.',
        name: 'connectionError',
      );

  String get ok => Intl.message(
        'OK',
        name: 'ok',
      );
}
