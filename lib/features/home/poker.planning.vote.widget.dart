import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';

class VoteWidget extends StatelessWidget {
  final String value;
  final bool isSelected;

  const VoteWidget({super.key, required this.value, required this.isSelected});

  void onPressed() {
    debugPrint('Received click $value');
  }

  @override
  Widget build(BuildContext context) {
    const size = Size.square(48);
    final text = Text(value, style: Theme.of(context).textTheme.headline6);
    final EdgeInsetsGeometry edgeInsets = EdgeInsets.all(spacing(0.5));

    return Padding(
      padding: edgeInsets,
      child: isSelected
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: size),
              onPressed: onPressed,
              child: text,
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: size),
              onPressed: onPressed,
              child: text,
            ),
    );
  }
}
