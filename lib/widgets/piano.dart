import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:flutter_remote_piano/localizations/app_localizations.dart';
import 'package:flutter_remote_piano/platforms/sound_base.dart';
import 'package:flutter_remote_piano/widgets/connection_button.dart';
import 'package:flutter_remote_piano/widgets/black_key.dart';
import 'package:flutter_remote_piano/widgets/white_key.dart';

class Piano extends StatelessWidget {
  const Piano();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(l(context).appTitle),
        actions: const <Widget>[ConnectionButton()],
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
                    WhiteKey(Notes.c1),
                    WhiteKey(Notes.d1),
                    WhiteKey(Notes.e1),
                    WhiteKey(Notes.f1),
                    WhiteKey(Notes.g1),
                    WhiteKey(Notes.a1),
                    WhiteKey(Notes.b1),
                    WhiteKey(Notes.c2),
                    WhiteKey(Notes.d2),
                    WhiteKey(Notes.e2),
                  ],
                ),
                Positioned(
                  left: keyWidth / 2,
                  top: 0.0,
                  right: null,
                  bottom: null,
                  child: Row(
                    children: const <Widget>[
                      BlackKey(Notes.cm1),
                      BlackKey(Notes.dm1),
                      BlackKeySpace(),
                      BlackKey(Notes.fm1),
                      BlackKey(Notes.gm1),
                      BlackKey(Notes.am1),
                      BlackKeySpace(),
                      BlackKey(Notes.cm2),
                      BlackKey(Notes.dm2),
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
