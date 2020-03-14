// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("遥控弹钢琴"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "connect" : MessageLookupByLibrary.simpleMessage("连接"),
    "connectionError" : MessageLookupByLibrary.simpleMessage("无法连接。"),
    "eg" : MessageLookupByLibrary.simpleMessage("范例："),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("失误"),
    "hostTitle" : MessageLookupByLibrary.simpleMessage("主机名或IP地址"),
    "ok" : MessageLookupByLibrary.simpleMessage("好"),
    "platformError" : MessageLookupByLibrary.simpleMessage("该平台不支持远程操作。"),
    "port" : MessageLookupByLibrary.simpleMessage("端口号"),
    "validationError" : MessageLookupByLibrary.simpleMessage("请正确输入。"),
    "webLimitation" : MessageLookupByLibrary.simpleMessage("网络上的限制：\n・要开始接收，您需要按键盘上的任意键。\n・您只能发送您按的第一个声音。 接待是无限的。")
  };
}
