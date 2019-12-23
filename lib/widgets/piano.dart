import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:flutter_remote_piano/common/settings.dart';
import 'package:flutter_remote_piano/platforms/sound_base.dart';
import 'package:flutter_remote_piano/widgets/connect_button.dart';
import 'package:flutter_remote_piano/widgets/black_key.dart';
import 'package:flutter_remote_piano/widgets/white_key.dart';

class Piano extends StatelessWidget {
  const Piano();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppSettings.appTitle),
        actions: const <Widget>[ConnectButton()],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            final keyWidth = maxWidth / SoundBase.whiteNum;

            return Provider<Tuple2<double, double>>.value(
              value: Tuple2(maxWidth, maxHeight),
              child: Stack(children: <Widget>[
                Row(
                  children: const <Widget>[
                    WhiteKey(Notes.C1),
                    WhiteKey(Notes.D1),
                    WhiteKey(Notes.E1),
                    WhiteKey(Notes.F1),
                    WhiteKey(Notes.G1),
                    WhiteKey(Notes.A1),
                    WhiteKey(Notes.B1),
                    WhiteKey(Notes.C2),
                    WhiteKey(Notes.D2),
                    WhiteKey(Notes.E2),
                  ],
                ),
                Positioned(
                  left: keyWidth / 2,
                  top: 0.0,
                  right: null,
                  bottom: null,
                  child: Row(
                    children: const <Widget>[
                      BlackKey(Notes.C1_),
                      BlackKey(Notes.D1_),
                      BlackKeySpace(),
                      BlackKey(Notes.F1_),
                      BlackKey(Notes.G1_),
                      BlackKey(Notes.A1_),
                      BlackKeySpace(),
                      BlackKey(Notes.C2_),
                      BlackKey(Notes.D2_),
                    ],
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
