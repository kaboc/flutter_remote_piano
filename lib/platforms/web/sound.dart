// ignore: avoid_web_libraries_in_flutter
import 'dart:js';

import 'package:flutter_remote_piano/platforms/sound_base.dart';

export 'package:flutter_remote_piano/platforms/sound_base.dart';

class Sound extends SoundBase {
  late final dynamic _synth;

  @override
  void init() {
    // ignore: avoid_dynamic_calls
    _synth = JsObject(context['Tone']['PolySynth'] as JsFunction)
        .callMethod('toMaster');
  }

  @override
  Future<void> play(int pitch) async {
    final octaveNum = (pitch / 12).floor();
    final noteName = '${SoundBase.toName(pitch)}$octaveNum';

    // ignore: avoid_dynamic_calls
    _synth.callMethod('triggerAttackRelease', [noteName, '8n']);
  }
}
