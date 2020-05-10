import 'package:flutter/material.dart';

import 'package:flutter_remote_piano/localizations/app_localizations.dart';

class ErrorDialog extends StatelessWidget {
  final BuildContext _context;
  final String message;
  final VoidCallback onConfirm;

  const ErrorDialog({
    @required BuildContext context,
    @required this.message,
    this.onConfirm,
  }) : _context = context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            l(context).errorTitle,
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                l(context).ok,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
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
}
