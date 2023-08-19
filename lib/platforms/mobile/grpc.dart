import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

import 'package:flutter_remote_piano/platforms/grpc_base.dart';
import 'package:flutter_remote_piano/src/pb/piano.pbgrpc.dart';

class Grpc extends GrpcBase<ClientChannel> {
  @override
  void init({required String host, required int port}) {
    channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry: CodecRegistry(
          codecs: const [GzipCodec(), IdentityCodec()],
        ),
      ),
    );

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

    final responses = client!.connect(
      requestStream(),
      options: CallOptions(compression: const GzipCodec()),
    );

    responses.listen((note) {
      onResponse(note.pitch);
    }).onError((Object? e) {
      debugPrint('$e');
      onDisconnected();

      if (e is GrpcError) {
        final message = e.message ?? '';
        switch (e.code) {
          case StatusCode.cancelled:
          case StatusCode.unknown when message.contains('errorCode: 0'):
            break;
          default:
            onConnectionError();
        }
      }
    });
  }

  @override
  Future<void> terminate() async {
    await channel?.terminate();
    channel = null;
  }
}
