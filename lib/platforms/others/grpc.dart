import 'dart:async';

import 'package:flutter_remote_piano/platforms/grpc_base.dart';

class Grpc extends GrpcBase<void> {
  @override
  void init({required String host, required int port}) {}

  @override
  Future<void> connect({
    required ResponseHandler onResponse,
    required DisconnectionHandler onDisconnected,
    required ErrorHandler onPlatformError,
    required ErrorHandler onConnectionError,
  }) async {
    onDisconnected();
    onPlatformError();
  }

  @override
  Future<void> terminate() async {}
}
