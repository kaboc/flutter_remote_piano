import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/common/connection_states.dart';
import 'package:flutter_remote_piano/widgets/connection_dialog.dart';

export 'package:flutter_remote_piano/widgets/connection_dialog.dart';

const _icons = <Icon>[
  Icon(Icons.link_off, color: Colors.grey),
  Icon(Icons.link, color: Colors.orange),
];

class ConnectionButton extends StatelessWidget {
  const ConnectionButton();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RemoteBloc>(context, listen: false);

    return StreamBuilder<ConnectionStates>(
      stream: bloc.state,
      initialData: ConnectionStates.off,
      builder: (context, snapshot) {
        return IconButton(
          icon: _icons[snapshot.data.index],
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
