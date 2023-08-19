import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc_web.dart';

import 'package:flutter_remote_piano/platforms/grpc_base.dart';
import 'package:flutter_remote_piano/src/pb/piano.pbgrpc.dart';

class Grpc extends GrpcBase<GrpcWebClientChannel> {
  @override
  void init({required String host, required int port}) {
    channel = GrpcWebClientChannel.xhr(Uri.parse('http://$host:$port'));
    client = PianoClient(channel!);
  }

  @override
  Future<void> connect({
    required ResponseHandler onResponse,
    required DisconnectionHandler onDisconnected,
    required ErrorHandler onPlatformError,
    required ErrorHandler onConnectionError,
  }) async {
    if (client == null) {
      onConnectionError();
      return;
    }

    final responses = client!.connect(requestStream());

    responses.listen((note) {
      onResponse(note.pitch);
    }).onError((Object? e) {
      debugPrint('$e');
      onDisconnected();

      if (e is GrpcError && e.code != StatusCode.cancelled) {
        onConnectionError();
      }
    });
  }

  @override
  Future<void> terminate() async {
    await channel?.terminate();
    channel = null;
  }
}
