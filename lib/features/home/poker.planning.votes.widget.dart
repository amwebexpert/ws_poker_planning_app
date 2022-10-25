import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.model.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.room.store.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.vote.widget.dart';
import 'package:ws_poker_planning_app/service.locator.dart';

class VotesWidget extends StatelessWidget {
  final PokerPlanningRoomStore store = serviceLocator.get();

  VotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final VotingCardsCategory votingCategory = store.pokerPlanningSessionInfo.votingCategory;
      final List<String> values = cardsListingCategories[votingCategory]!.values;

      return Wrap(
          alignment: WrapAlignment.center,
          children: values.map((value) => VoteWidget(value: value, isSelected: value == store.estimate)).toList());
    });
  }
}
