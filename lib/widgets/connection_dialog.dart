import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/common/l10n.dart';
import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/widgets/error_dialog.dart';

class HostController extends TextEditingController {
  HostController({super.text});
}

class PortController extends TextEditingController {
  PortController({super.text});
}

class ConnectionDialog extends StatelessWidget {
  const ConnectionDialog({required BuildContext context}) : _context = context;

  final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    final hostController = Provider.of<HostController>(_context, listen: false);
    final portController = Provider.of<PortController>(_context, listen: false);

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          content: Column(
            children: [
              if (kIsWeb) Text(l(context).webLimitation),
              if (kIsWeb) const SizedBox(height: 16.0),
              TextField(
                controller: hostController,
                keyboardType: TextInputType.number,
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
          actions: [
            TextButton(
              child: Text(l(context).cancel),
              // style: TextButton.styleFrom(
              //   primary: Theme.of(context).colorScheme.onPrimary,
              // ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(l(context).connect),
              // style: TextButton.styleFrom(
              //   primary: Theme.of(context).colorScheme.onPrimary,
              // ),
              onPressed: () => _onPressed(
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
    required BuildContext context,
    required HostController hostController,
    required PortController portController,
  }) async {
    Navigator.pop(context);

    final host = hostController.text;
    final port = int.tryParse(portController.text);

    if (host.isEmpty || port == null || port.isNegative) {
      _showErrorDialog(l(_context).validationError);
      return;
    }

    await context.read<RemoteBloc>().connect(
          host: hostController.text,
          port: port,
          onPlatformError: () {
            _showErrorDialog(l(_context).platformError);
          },
          onConnectionError: () {
            _showErrorDialog(l(_context).connectionError);
          },
        );
  }

  void _showErrorDialog(String message) {
    ErrorDialog(
      context: _context,
      message: message,
      onConfirm: show,
    ).show();
  }
}
