import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter_remote_piano/common/exceptions.dart';
import 'package:flutter_remote_piano/platforms/grpc_base.dart';

class Grpc extends GrpcBase<void> {
  @override
  void init({@required String host, @required int port}) {}

  @override
  Future<void> connect(
      {ResponseHandler onResponse, ErrorHandler onError}) async {
    await onError();
    throw PlatformUnsupportedException();
  }

  @override
  Future<void> terminate() async {}
}
