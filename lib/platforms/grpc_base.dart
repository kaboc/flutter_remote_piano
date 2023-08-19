import 'dart:async';

import 'package:flutter_remote_piano/src/pb/piano.pbgrpc.dart';

typedef ResponseHandler = void Function(int);
typedef DisconnectionHandler = void Function();
typedef ErrorHandler = void Function();

abstract class GrpcBase<Channel> {
  Channel? channel;
  PianoClient? client;
  final _requestController = StreamController<int>.broadcast();

  void init({required String host, required int port});

  Future<void> connect({
    required ResponseHandler onResponse,
    required DisconnectionHandler onDisconnected,
    required ErrorHandler onPlatformError,
    required ErrorHandler onConnectionError,
  });

  Future<void> terminate();

  Stream<Note> requestStream() async* {
    await for (final pitch in _requestController.stream) {
      yield Note()..pitch = pitch;
    }
  }

  void addRequest(int pitch) {
    if (channel != null) {
      _requestController.sink.add(pitch);
    }
  }

  void dispose() {
    terminate();
    _requestController.close();
  }
}
