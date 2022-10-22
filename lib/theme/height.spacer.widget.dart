import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';

class HeightSpacer extends StatelessWidget {
  final double spacingUnitCount;

  const HeightSpacer({Key? key, this.spacingUnitCount = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: spacing(spacingUnitCount));
}
