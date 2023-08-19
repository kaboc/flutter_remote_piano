import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

class Sound extends SoundBase {
  @override
  void init() => throw UnimplementedError();

  @override
  Future<void> play(int pitch) => throw UnimplementedError();
}
