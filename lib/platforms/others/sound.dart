import 'package:flutter_remote_piano/common/exceptions.dart';
import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

class Sound extends SoundBase {
  @override
  void init() => throw PlatformUnsupportedException();

  @override
  Future<void> play(int pitch) => throw PlatformUnsupportedException();
}
