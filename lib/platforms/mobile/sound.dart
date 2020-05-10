import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

const _fontPath = 'assets/sf2/Piano.SF2';

class Sound extends SoundBase {
  FlutterMidi midi = FlutterMidi();

  @override
  Future<void> init() async {
    midi.unmute();
    await rootBundle.load(_fontPath).then((sf2) async {
      midi.prepare(sf2: sf2);

      // HACK: Reduces the chance of getting an exception, which can occur when
      // notes are played before midi becoming ready, by this short wait
      // (instead of awaiting midi.prepare() that seems to last forever).
      await Future<void>.delayed(const Duration(milliseconds: 200));
    });
  }

  @override
  void play(int pitch) {
    midi.playMidiNote(midi: pitch);
  }
}
