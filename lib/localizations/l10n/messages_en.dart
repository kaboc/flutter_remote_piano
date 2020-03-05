// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("Remote Piano"),
    "cancel" : MessageLookupByLibrary.simpleMessage("CANCEL"),
    "connect" : MessageLookupByLibrary.simpleMessage("CONNECT"),
    "connectionError" : MessageLookupByLibrary.simpleMessage("Connection failed."),
    "eg" : MessageLookupByLibrary.simpleMessage("e.g."),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("ERROR"),
    "hostTitle" : MessageLookupByLibrary.simpleMessage("Hostname or IP address"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "platformError" : MessageLookupByLibrary.simpleMessage("Remote operation is not supported\non this platform."),
    "port" : MessageLookupByLibrary.simpleMessage("Port number"),
    "validationError" : MessageLookupByLibrary.simpleMessage("Please enter information correctly."),
    "webLimitation" : MessageLookupByLibrary.simpleMessage("Limitations on the web:\n- Any one of piano keys must be pressed to start listening to the server.\n- Only the first note can be sent.")
  };
}
