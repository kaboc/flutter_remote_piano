// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_HK locale. All the
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
  String get localeName => 'zh_HK';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("遙控彈鋼琴"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "connect" : MessageLookupByLibrary.simpleMessage("連接"),
    "connectionError" : MessageLookupByLibrary.simpleMessage("無法連接。"),
    "eg" : MessageLookupByLibrary.simpleMessage("範例："),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("失誤"),
    "hostTitle" : MessageLookupByLibrary.simpleMessage("主機名或IP地址"),
    "ok" : MessageLookupByLibrary.simpleMessage("好"),
    "platformError" : MessageLookupByLibrary.simpleMessage("該平台不支持遠程操作。"),
    "port" : MessageLookupByLibrary.simpleMessage("端口號"),
    "validationError" : MessageLookupByLibrary.simpleMessage("請正確輸入。"),
    "webLimitation" : MessageLookupByLibrary.simpleMessage("網絡上的限制：\n・要開始接收，您需要按鍵盤上的任意鍵。\n・您只能發送您按的第一個聲音。 接待是無限的。")
  };
}
