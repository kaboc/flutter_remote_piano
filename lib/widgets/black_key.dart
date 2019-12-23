import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/platforms/sound_base.dart';

class BlackKey extends StatelessWidget {
  final Notes note;

  const BlackKey(this.note);

  static const widthRatio = 0.75;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RemoteBloc>(context);

    final screenSize = Provider.of<Tuple2<double, double>>(context);
    final width = screenSize.item1 / SoundBase.whiteNum;
    final height = screenSize.item2;

    final pitch = SoundBase.toPitch(note);

    return GestureDetector(
      child: StreamBuilder<bool>(
        stream: bloc.tapped(note.index),
        initialData: false,
        builder: (context, snapshot) {
          return Container(
            width: width * widthRatio,
            height: height * 0.6,
            margin:
                EdgeInsets.symmetric(horizontal: width * (1 - widthRatio) / 2),
            decoration: BoxDecoration(
              color: snapshot.data ? Colors.grey : Colors.black,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Opacity(
              child: Text(
                SoundBase.toName(pitch),
                style: const TextStyle(fontSize: 18.0),
              ),
              opacity: snapshot.data ? 1.0 : 0.0,
            ),
          );
        },
      ),
      onTapDown: (_) => bloc.play(pitch),
    );
  }
}

class BlackKeySpace extends StatelessWidget {
  const BlackKeySpace();

  @override
  Widget build(BuildContext context) {
    final size = Provider.of<Tuple2<double, double>>(context);
    return SizedBox(width: size.item1 / SoundBase.whiteNum);
  }
}
