import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/platforms/sound_base.dart';

class WhiteKey extends StatelessWidget {
  const WhiteKey(this.note);

  final Notes note;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RemoteBloc>(context, listen: false);

    final pitch = SoundBase.toPitch(note);

    return Expanded(
      child: GestureDetector(
        child: StreamBuilder<bool>(
          stream: bloc.tapped(note.index),
          initialData: false,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                color: snapshot.data! ? Colors.grey : Colors.white,
                border: const Border.fromBorderSide(BorderSide()),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                SoundBase.toName(pitch),
                style: const TextStyle(fontSize: 18.0),
              ),
            );
          },
        ),
        onTapDown: (_) => bloc.play(pitch),
      ),
    );
  }
}
