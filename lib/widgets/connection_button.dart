import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/common/connection_states.dart';
import 'package:flutter_remote_piano/widgets/connection_dialog.dart';

export 'package:flutter_remote_piano/widgets/connection_dialog.dart';

const _icons = <IconData>[
  Icons.link_off,
  Icons.link,
//  Icons.music_note,
];

const _iconColors = <Color>[
  Colors.grey,
//  Colors.grey,
  Colors.orange,
];

class ConnectionButton extends StatelessWidget {
  const ConnectionButton();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RemoteBloc>(context);

    return StreamBuilder<ConnectionStates>(
      stream: bloc.state,
      initialData: ConnectionStates.off,
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(_icons[snapshot.data.index]),
          color: _iconColors[snapshot.data.index],
          onPressed: () async {
            snapshot.data == ConnectionStates.ready
                ? await bloc.disconnect()
                : ConnectionDialog(context: context).show();
          },
        );
      },
    );
  }
}
