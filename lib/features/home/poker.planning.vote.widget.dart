import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.room.store.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';

class VoteWidget extends StatelessWidget {
  final String value;
  final bool isSelected;
  final bool isEnabled;

  const VoteWidget({super.key, required this.value, required this.isSelected, required this.isEnabled});

  void onPressed() {
    final PokerPlanningRoomStore store = serviceLocator.get();
    if (store.estimate == value) {
      store.estimateTask(null); // user is removing his/her current vote
    } else {
      store.estimateTask(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    const size = Size.square(48);
    final text = Text(value, style: Theme.of(context).textTheme.headline6);
    final onPressHandler = isEnabled ? onPressed : null;

    return Padding(
      padding: EdgeInsets.all(spacing(0.5)),
      child: isSelected
          ? ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: size), onPressed: onPressHandler, child: text)
          : OutlinedButton(style: OutlinedButton.styleFrom(minimumSize: size), onPressed: onPressHandler, child: text),
    );
  }
}
