enum Notes {
  C1,
  C1_,
  D1,
  D1_,
  E1,
  F1,
  F1_,
  G1,
  G1_,
  A1,
  A1_,
  B1,
  C2,
  C2_,
  D2,
  D2_,
  E2,
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

  void play(int pitch);

  static int toPitch(Notes note) {
    return basePitch + note.index;
  }

  static String toName(int pitch) {
    final int keyNum = pitch % 12;
    return _noteNames[keyNum];
  }
}
