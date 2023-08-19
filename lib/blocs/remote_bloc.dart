import 'dart:async';

import 'package:flutter_remote_piano/common/connection_states.dart';
import 'package:flutter_remote_piano/platforms/grpc_base.dart';

class RemoteBloc {
  RemoteBloc({
    required this.grpc,
    required this.basePitch,
    required int numberOfKeys,
  }) {
    for (var i = 0; i < numberOfKeys; i++) {
      _tapControllers.add(StreamController<bool>());
    }
  }

  final GrpcBase<Object?> grpc;
  final int basePitch;

  final _stateController = StreamController<ConnectionStates>();
  final _soundController = StreamController<int>();
  final _tapControllers = <StreamController<bool>>[];

  Stream<ConnectionStates> get state => _stateController.stream;
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

  Future<void> connect({
    required String host,
    required int port,
    required ErrorHandler onPlatformError,
    required ErrorHandler onConnectionError,
  }) async {
    _toggleButton(ConnectionStates.ready);

    grpc.init(host: host, port: port);
    await grpc.connect(
      onResponse: _executeTap,
      onDisconnected: terminate,
      onPlatformError: onPlatformError,
      onConnectionError: onConnectionError,
    );
  }

  void play(int pitch) {
    _executeTap(pitch);
    grpc.addRequest(pitch);
  }

  Future<void> terminate() async {
    await grpc.terminate();
    _toggleButton(ConnectionStates.off);
  }

  void _toggleButton(ConnectionStates state) {
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
