import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

const _fontPath = 'assets/sf2/Piano.SF2';

class Sound extends SoundBase {
  @override
  void init() {
    FlutterMidi.unmute();
    rootBundle.load(_fontPath).then((sf2) => FlutterMidi.prepare(sf2: sf2));
  }

  @override
  void play(int pitch) {
    FlutterMidi.playMidiNote(midi: pitch);
  }
}
