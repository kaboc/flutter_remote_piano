import 'dart:js';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

class Sound extends SoundBase {
  dynamic _synth;

  @override
  Future<void> init() async {
    _synth = JsObject(context['Tone']['PolySynth'] as JsFunction)
        .callMethod('toMaster');
  }

  @override
  void play(int pitch) {
    final octaveNum = (pitch / 12).floor();
    final noteName = '${SoundBase.toName(pitch)}$octaveNum';

    _synth.callMethod('triggerAttackRelease', [noteName, '8n']);
  }
}
