import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_remote_piano/common/exceptions.dart';
import 'package:flutter_remote_piano/platforms/grpc_base.dart';
import 'package:flutter_remote_piano/src/pb/piano.pbgrpc.dart';

class Grpc extends GrpcBase<ClientChannel> {
  @override
  void init({@required String host, @required int port}) {
    channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    client = PianoClient(channel);
  }

  @override
  Future<void> connect(
      {ResponseHandler onResponse, ErrorHandler onError}) async {
    final responses = client.connect(requestStream());

    try {
      await for (final res in responses) {
        onResponse(res.pitch);
      }
    } catch (e) {
      print(e);
      if (e.toString().contains('SocketException')) {
        await onError();
        throw ConnectionFailureException();
      }
    }

    await onError();
  }

  @override
  Future<void> terminate() async {
    await channel?.terminate();
    channel = null;
  }
}
