import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.model.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.vote.widget.dart';

class VotePanelWidget extends StatelessWidget {
  const VotePanelWidget({super.key});

  final VotingCardsCategory votingCategory = VotingCardsCategory.fibonnacy;
  final String vote = '3';

  @override
  Widget build(BuildContext context) {
    final values = cardsListingCategories[votingCategory]!.values;
    return Wrap(
        alignment: WrapAlignment.center,
        children: values.map((value) => VoteWidget(value: value, isSelected: value == vote)).toList());
  }
}
