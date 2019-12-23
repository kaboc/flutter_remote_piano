import 'dart:async';
import 'package:grpc/grpc_web.dart';
import 'package:meta/meta.dart';

import 'package:flutter_remote_piano/platforms/grpc_base.dart';
import 'package:flutter_remote_piano/src/pb/piano.pbgrpc.dart';

class Grpc extends GrpcBase<GrpcWebClientChannel> {
  @override
  void init({@required String host, @required int port}) {
    channel = GrpcWebClientChannel.xhr(Uri.parse('http://$host:$port'));
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
      await onError();
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> terminate() async {
    await channel?.terminate();
    channel = null;
  }
}
