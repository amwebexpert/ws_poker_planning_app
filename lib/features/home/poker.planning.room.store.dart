import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.model.dart';
import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.dart';
import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.model.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/services/storage/shared.preferences.enum.dart';
import 'package:ws_poker_planning_app/services/storage/shared.preferences.services.dart';

// Include generated file
part 'poker.planning.room.store.g.dart';

// This is the class used by rest of the codebase
class PokerPlanningRoomStore extends _PokerPlanningRoomStoreBase with _$PokerPlanningRoomStore {}

// The store-class
abstract class _PokerPlanningRoomStoreBase with Store {
  final LoggerService _logger = serviceLocator.get();
  final SharedPreferencesService _preferences = serviceLocator.get();
  final PokerPlanningService pokerService = serviceLocator.get();

  @observable
  String? estimate;

  @observable
  PokerPlanningSessionInfo pokerPlanningSessionInfo = PokerPlanningSessionInfo();

  @observable
  PokerPlanningSession? session;

  _PokerPlanningRoomStoreBase() {
    final defaultValue = jsonEncode(PokerPlanningSessionInfo().toJson());
    final json = _preferences.getString(SharedPreferenceKey.lastPokerPlanningRoom.name, defaultValue: defaultValue);
    pokerPlanningSessionInfo = PokerPlanningSessionInfo.fromJson(jsonDecode(json));
  }

  @computed
  bool get isMemberOfRoom =>
      pokerPlanningSessionInfo.isPopulated && session != null && session!.hasMember(pokerPlanningSessionInfo.username);

  bool get isSessionStarted => pokerService.isSessionStarted;

  @action
  void join() {
    if (!pokerPlanningSessionInfo.isPopulated) {
      return;
    }

    pokerService.startSession(
        hostname: pokerPlanningSessionInfo.hostname,
        roomUUID: pokerPlanningSessionInfo.roomUUID,
        isSecure: pokerPlanningSessionInfo.isSecure,
        onConnectionSuccess: onConnectionSuccess);

    pokerService.stream.listen((updatedSessionInfo) {
      _logger.info('[PokerPlanningRoomStore] receiving: ${updatedSessionInfo.toJson()}');
      session = updatedSessionInfo;
      if (!isMemberOfRoom) {
        estimate = null;
      }
    });
  }

  void onConnectionSuccess() {
    if (!isMemberOfRoom && pokerPlanningSessionInfo.isPopulated) {
      estimateTask(null); // entering the room for the very 1st time
    }
  }

  @action
  void estimateTask(String? newEstimate) {
    estimate = newEstimate;
    pokerService.estimate(pokerPlanningSessionInfo.username, newEstimate);
  }

  @action
  void updatePokerPlanningSessionInfo(PokerPlanningSessionInfo info) {
    // deep clone to make sure the reference is changing
    pokerPlanningSessionInfo = PokerPlanningSessionInfo.fromJson(info.toJson());

    final CardsListingCategory cards = cardsListingCategories[pokerPlanningSessionInfo.votingCategory]!;
    if (!cards.values.contains(estimate)) {
      estimate = null;
    }

    final String key = SharedPreferenceKey.lastPokerPlanningRoom.name;
    final String json = jsonEncode(pokerPlanningSessionInfo);
    _preferences.setString(key, json).onError((e, stackTrace) {
      _logger.error("Can't write preference $key", error: e, stackTrace: stackTrace);
      return false;
    });
  }
}
