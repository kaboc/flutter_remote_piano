enum Notes {
  c1,
  cm1,
  d1,
  dm1,
  e1,
  f1,
  fm1,
  g1,
  gm1,
  a1,
  am1,
  b1,
  c2,
  cm2,
  d2,
  dm2,
  e2,
}

const _noteNames = [
  'C',
  'C#',
  'D',
  'D#',
  'E',
  'F',
  'F#',
  'G',
  'G#',
  'A',
  'A#',
  'B',
  'B#',
];

const _baseOctave = 5;

abstract class SoundBase {
  static const basePitch = _baseOctave * 12;
  static const whiteNum = 10;
  static const blackNum = 7;

  void init();

  Future<void> play(int pitch);

  static int toPitch(Notes note) {
    return basePitch + note.index;
  }

  static String toName(int pitch) {
    final int keyNum = pitch % 12;
    return _noteNames[keyNum];
  }
}
