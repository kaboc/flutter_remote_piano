import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flutter_remote_piano/platforms/grpc_base.dart';

import 'package:flutter_remote_piano/common/connection.dart';

class RemoteBloc {
  final GrpcBase grpc;
  final int basePitch;

  RemoteBloc({
    @required this.grpc,
    @required this.basePitch,
    @required int numberOfKeys,
  }) {
    for (int i = 0; i < numberOfKeys; i++) {
      _tapControllers.add(StreamController<bool>());
    }
  }

  final _stateController = StreamController<Connection>();
  final _soundController = StreamController<int>();
  final _tapControllers = <StreamController<bool>>[];

  Stream<Connection> get state => _stateController.stream;
  Stream<int> get pitch => _soundController.stream;
  Stream<bool> tapped(int keyIndex) => _tapControllers[keyIndex].stream;

  void dispose() {
    grpc.dispose();

    _stateController.close();
    _soundController.close();

    for (final controller in _tapControllers) {
      controller.close();
    }
    _tapControllers.clear();
  }

  Future<void> connect({@required String host, @required int port}) async {
    _toggleButton(Connection.Ready);

    grpc.init(host: host, port: port);
    await grpc.connect(
      onResponse: (pitch) => _executeTap(pitch),
      onError: () async => await disconnect(),
    );
  }

  void play(int pitch) {
    _executeTap(pitch);
    grpc.addRequest(pitch);
  }

  Future<void> disconnect() async {
    await grpc.terminate();
    _toggleButton(Connection.Off);
  }

  void _toggleButton(Connection state) {
    _stateController.sink.add(state);
  }

  void _executeTap(int pitch) {
    final keyIndex = pitch - basePitch;
    _soundController.sink.add(pitch);

    if (keyIndex >= 0 && keyIndex < _tapControllers.length) {
      _tapControllers[keyIndex].sink.add(true);

      Future.delayed(
        const Duration(milliseconds: 200),
        () => _tapControllers[keyIndex].sink.add(false),
      );
    }
  }
}
