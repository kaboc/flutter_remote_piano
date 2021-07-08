import 'dart:async';
import 'package:grpc/grpc.dart';

import 'package:flutter_remote_piano/common/exceptions.dart';
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
    required ErrorHandler onError,
  }) async {
    if (client == null) {
      await onError();
      return;
    }

    final responses = client!.connect(
      requestStream(),
      options: CallOptions(compression: const GzipCodec()),
    );

    try {
      await for (final res in responses) {
        onResponse(res.pitch);
      }
    } on GrpcError catch (e) {
      // GrpcError or another exception was thrown at older versions
      // of the grpc package when the server was terminated, but
      // it appears that no exception is thrown with the latest version.
      print(e);
      await onError();
      // It looks like the "UNAVAILABLE" error occurs when the connection
      // is cut off by the user, which shouldn't be handled as an error,
      // so here it is excluded from the error types to show an error dialog.
      if (e.code != StatusCode.unavailable) {
        throw ConnectionFailureException();
      }
    } catch (e) {
      print(e);
      await onError();
    }

    await onError();
  }

  @override
  Future<void> terminate() async {
    await channel?.terminate();
    channel = null;
  }
}
