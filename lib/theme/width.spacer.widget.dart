import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';

class WidthSpacer extends StatelessWidget {
  final double spacingUnitCount;

  const WidthSpacer({Key? key, this.spacingUnitCount = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: spacing(spacingUnitCount));
}
