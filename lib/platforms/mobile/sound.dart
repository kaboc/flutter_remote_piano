import 'package:flutter/foundation.dart';
import 'package:flutter_midi_pro/flutter_midi_pro.dart';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

class Sound extends SoundBase {
  final _midi = MidiPro();

  @override
  Future<void> init() async {
    await _midi.loadSoundfont(sf2Path: 'assets/sf2/Piano.SF2');
  }

  @override
  Future<void> play(int pitch) async {
    try {
      await _midi.playMidiNote(midi: pitch, velocity: 127);
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
}
