import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/platforms/sound_base.dart';

const _widthRatio = 0.75;

class BlackKey extends StatelessWidget {
  const BlackKey(this.note);

  final Notes note;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RemoteBloc>(context, listen: false);

    final screenSize = context.watch<Size>();
    final width = screenSize.width / SoundBase.whiteNum;
    final height = screenSize.height;

    final pitch = SoundBase.toPitch(note);

    return GestureDetector(
      child: StreamBuilder<bool>(
        stream: bloc.tapped(note.index),
        initialData: false,
        builder: (context, snapshot) {
          return Container(
            width: width * _widthRatio,
            height: height * 0.6,
            margin:
                EdgeInsets.symmetric(horizontal: width * (1 - _widthRatio) / 2),
            decoration: BoxDecoration(
              color: snapshot.data! ? Colors.grey : Colors.black,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8.0),
              ),
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Opacity(
              opacity: snapshot.data! ? 1.0 : 0.0,
              child: Text(
                SoundBase.toName(pitch),
                style: const TextStyle(fontSize: 18.0),
              ),
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
    final size = context.watch<Size>();
    return SizedBox(width: size.width / SoundBase.whiteNum);
  }
}
