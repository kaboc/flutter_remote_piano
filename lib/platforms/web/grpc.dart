import 'dart:async';
import 'package:grpc/grpc_web.dart';
import 'package:meta/meta.dart';

import 'package:flutter_remote_piano/common/exceptions.dart';
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

    // It does not seem handling of exceptions on web is as reliable as on motile.
    // They are caught properly in some cases, but not in other cases.
    try {
      await for (final res in responses) {
        onResponse(res.pitch);
      }
    } on GrpcError catch (e) {
      print(e);
      await onError();
      if (e.code == StatusCode.unavailable) {
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
