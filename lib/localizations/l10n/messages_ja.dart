// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("リモートピアノ"),
    "cancel" : MessageLookupByLibrary.simpleMessage("キャンセル"),
    "connect" : MessageLookupByLibrary.simpleMessage("接続"),
    "connectionError" : MessageLookupByLibrary.simpleMessage("接続できませんでした。"),
    "eg" : MessageLookupByLibrary.simpleMessage("例："),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("エラー"),
    "hostTitle" : MessageLookupByLibrary.simpleMessage("ホスト名 または IPアドレス"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "platformError" : MessageLookupByLibrary.simpleMessage("このプラットフォームは\nリモート操作に対応していません。"),
    "port" : MessageLookupByLibrary.simpleMessage("ポート番号"),
    "validationError" : MessageLookupByLibrary.simpleMessage("正しく入力してください。")
  };
}
