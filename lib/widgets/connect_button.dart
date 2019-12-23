import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/common/connection.dart';
import 'package:flutter_remote_piano/widgets/connect_dialog.dart';

export 'package:flutter_remote_piano/widgets/connect_dialog.dart';

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

class ConnectButton extends StatelessWidget {
  const ConnectButton();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RemoteBloc>(context);

    return StreamBuilder<Connection>(
      stream: bloc.state,
      initialData: Connection.Off,
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(_icons[snapshot.data.index]),
          color: _iconColors[snapshot.data.index],
          onPressed: () async {
            snapshot.data == Connection.Ready
                ? await bloc.disconnect()
                : ConnectDialog(context: context).show();
          },
        );
      },
    );
  }
}
