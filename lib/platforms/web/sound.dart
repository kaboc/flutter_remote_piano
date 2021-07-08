import 'dart:js';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

class Sound extends SoundBase {
  late final dynamic _synth;

  @override
  void init() {
    _synth = JsObject(context['Tone']['PolySynth'] as JsFunction)
        .callMethod('toMaster');
  }

  @override
  Future<void> play(int pitch) async {
    final octaveNum = (pitch / 12).floor();
    final noteName = '${SoundBase.toName(pitch)}$octaveNum';

    _synth.callMethod('triggerAttackRelease', [noteName, '8n']);
  }
}
