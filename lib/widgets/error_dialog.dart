import 'package:flutter/material.dart';

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
    return AlertDialog(
      title: const Text('ERROR', style: TextStyle(color: Colors.red)),
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: <Widget>[
        RaisedButton(
          child: const Text('OK', style: TextStyle(color: Colors.white)),
          color: Colors.red,
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
        ),
      ],
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }
}
