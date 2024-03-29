import 'package:flutter/material.dart';

import 'package:flutter_remote_piano/common/l10n.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required BuildContext context,
    required this.message,
    this.onConfirm,
  }) : _context = context;

  final BuildContext _context;
  final String message;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            l(context).errorTitle,
            style: const TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                l(context).ok,
                style: const TextStyle(color: Colors.white),
              ),
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
