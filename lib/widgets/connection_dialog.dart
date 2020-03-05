import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/common/exceptions.dart';
import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/localizations/app_localizations.dart';
import 'package:flutter_remote_piano/widgets/error_dialog.dart';

class HostController = TextEditingController with Type;
class PortController = TextEditingController with Type;

class ConnectionDialog extends StatelessWidget {
  final BuildContext _context;

  const ConnectionDialog({@required BuildContext context}) : _context = context;

  @override
  Widget build(BuildContext context) {
    final hostController = Provider.of<HostController>(_context, listen: false);
    final portController = Provider.of<PortController>(_context, listen: false);

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          content: Column(
            children: <Widget>[
              if (kIsWeb)
                Text('${l(context).webLimitation}'),
              if (kIsWeb)
                const SizedBox(height: 16.0),
              TextField(
                controller: hostController,
                decoration: InputDecoration(
                  labelText: l(context).hostTitle,
                  hintText: '${l(context).eg} 192.168.111.222',
                ),
              ),
              TextField(
                controller: portController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l(context).port,
                  hintText: '${l(context).eg} 50051',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(l(context).cancel),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text(l(context).connect),
              onPressed: () async => await _onPressed(
                context: context,
                hostController: hostController,
                portController: portController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }

  Future<void> _onPressed({
    @required BuildContext context,
    @required HostController hostController,
    @required PortController portController,
  }) async {
    Navigator.pop(context);

    final host = hostController.text;
    final port = _toNumber(portController.text);

    if (host.isEmpty || port == null || port.isNegative) {
      _showErrorDialog(l(_context).validationError);
      return;
    }

    final bloc = Provider.of<RemoteBloc>(_context, listen: false);
    try {
      await bloc.connect(
        host: hostController.text,
        port: port,
      );
    } on PlatformUnsupportedException catch (_) {
      _showErrorDialog(l(_context).platformError);
    } on ConnectionFailureException catch (_) {
      _showErrorDialog(l(_context).connectionError);
    } catch (e) {
      print(e);
    }
  }

  int _toNumber(String text) {
    return text == null ? null : int.tryParse(text);
  }

  void _showErrorDialog(String message) {
    ErrorDialog(
      context: _context,
      message: message,
      onConfirm: show,
    ).show();
  }
}
