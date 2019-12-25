import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/common/exceptions.dart';
import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/widgets/error_dialog.dart';

class HostController = TextEditingController with Type;
class PortController = TextEditingController with Type;

class ConnectionDialog extends StatelessWidget {
  final BuildContext _context;

  const ConnectionDialog({@required BuildContext context}) : _context = context;

  @override
  Widget build(BuildContext context) {
    final hostController = Provider.of<HostController>(_context);
    final portController = Provider.of<PortController>(_context);

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          content: Column(
            children: <Widget>[
              TextField(
                controller: hostController,
                decoration: const InputDecoration(
                  labelText: 'Hostname or IP',
                  hintText: 'e.g. 192.168.111.222',
                ),
              ),
              TextField(
                controller: portController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Port',
                  hintText: 'e.g. 50051',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: const Text('CONNECT'),
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
      _showErrorDialog('Please enter information correctly.');
      return;
    }

    final bloc = Provider.of<RemoteBloc>(_context);
    try {
      await bloc.connect(
        host: hostController.text,
        port: port,
      );
    } on PlatformUnsupportedException catch (_) {
      _showErrorDialog('Remote operation is not supported\non this platform.');
    } on ConnectionFailureException catch (_) {
      _showErrorDialog('Connection failed.');
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
