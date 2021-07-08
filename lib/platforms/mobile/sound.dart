import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

const _fontPath = 'assets/sf2/Piano.SF2';

class Sound extends SoundBase {
  final FlutterMidi midi = FlutterMidi();

  @override
  void init() {
    midi.unmute();
    rootBundle.load(_fontPath).then((sf2) => midi.prepare(sf2: sf2));
  }

  @override
  Future<void> play(int pitch) async {
    try {
      await midi.playMidiNote(midi: pitch);
    } on PlatformException catch (_) {
      print(
        'An error occurred in the MIDI plugin; '
        'this typically occurs when a note is played '
        'before the sound font becomes ready.',
      );
    }
  }
}
