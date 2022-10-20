import 'package:flutter/material.dart';

import 'snackbar.model.dart';

class SnackbarWidget extends StatelessWidget {
  final String message;
  final SnackbarType type;

  const SnackbarWidget({Key? key, required this.message, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(snackbarIcons[type], color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 16),
        Expanded(child: Text(message)),
      ],
    );
  }
}
