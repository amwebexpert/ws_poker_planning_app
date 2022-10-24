import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.model.dart';
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

  @observable
  PokerPlanningSessionInfo pokerPlanningSessionInfo = PokerPlanningSessionInfo();

  _PokerPlanningRoomStoreBase() {
    final defaultValue = jsonEncode(PokerPlanningSessionInfo().toJson());
    final jsonStoredValue =
        _preferences.getString(SharedPreferenceKey.lastPokerPlanningRoom.name, defaultValue: defaultValue);
    final map = jsonDecode(jsonStoredValue);
    pokerPlanningSessionInfo = PokerPlanningSessionInfo.fromJson(map);
    pokerPlanningSessionInfo =
        PokerPlanningSessionInfo.fromJson(PokerPlanningSessionInfo.defaultLocalhost); // TODO For testing
  }

  @action
  void updatePokerPlanningSessionInfo(PokerPlanningSessionInfo info) {
    // deep clone to make sure the reference is changing
    pokerPlanningSessionInfo = PokerPlanningSessionInfo.fromJson(info.toJson());

    final String key = SharedPreferenceKey.lastPokerPlanningRoom.name;
    final String json = jsonEncode(pokerPlanningSessionInfo);
    _preferences.setString(key, json).onError((e, stackTrace) {
      _logger.error("Can't write preference $key", error: e, stackTrace: stackTrace);
      return false;
    });
  }
}
