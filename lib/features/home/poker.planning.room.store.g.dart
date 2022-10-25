// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poker.planning.room.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokerPlanningRoomStore on _PokerPlanningRoomStoreBase, Store {
  Computed<bool>? _$isMemberOfRoomComputed;

  @override
  bool get isMemberOfRoom =>
      (_$isMemberOfRoomComputed ??= Computed<bool>(() => super.isMemberOfRoom,
              name: '_PokerPlanningRoomStoreBase.isMemberOfRoom'))
          .value;

  late final _$estimateAtom =
      Atom(name: '_PokerPlanningRoomStoreBase.estimate', context: context);

  @override
  String? get estimate {
    _$estimateAtom.reportRead();
    return super.estimate;
  }

  @override
  set estimate(String? value) {
    _$estimateAtom.reportWrite(value, super.estimate, () {
      super.estimate = value;
    });
  }

  late final _$pokerPlanningSessionInfoAtom = Atom(
      name: '_PokerPlanningRoomStoreBase.pokerPlanningSessionInfo',
      context: context);

  @override
  PokerPlanningSessionInfo get pokerPlanningSessionInfo {
    _$pokerPlanningSessionInfoAtom.reportRead();
    return super.pokerPlanningSessionInfo;
  }

  @override
  set pokerPlanningSessionInfo(PokerPlanningSessionInfo value) {
    _$pokerPlanningSessionInfoAtom
        .reportWrite(value, super.pokerPlanningSessionInfo, () {
      super.pokerPlanningSessionInfo = value;
    });
  }

  late final _$sessionAtom =
      Atom(name: '_PokerPlanningRoomStoreBase.session', context: context);

  @override
  PokerPlanningSession? get session {
    _$sessionAtom.reportRead();
    return super.session;
  }

  @override
  set session(PokerPlanningSession? value) {
    _$sessionAtom.reportWrite(value, super.session, () {
      super.session = value;
    });
  }

  late final _$_PokerPlanningRoomStoreBaseActionController =
      ActionController(name: '_PokerPlanningRoomStoreBase', context: context);

  @override
  void estimateTask(String? newEstimate) {
    final _$actionInfo = _$_PokerPlanningRoomStoreBaseActionController
        .startAction(name: '_PokerPlanningRoomStoreBase.estimateTask');
    try {
      return super.estimateTask(newEstimate);
    } finally {
      _$_PokerPlanningRoomStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void join() {
    final _$actionInfo = _$_PokerPlanningRoomStoreBaseActionController
        .startAction(name: '_PokerPlanningRoomStoreBase.join');
    try {
      return super.join();
    } finally {
      _$_PokerPlanningRoomStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePokerPlanningSessionInfo(PokerPlanningSessionInfo info) {
    final _$actionInfo =
        _$_PokerPlanningRoomStoreBaseActionController.startAction(
            name: '_PokerPlanningRoomStoreBase.updatePokerPlanningSessionInfo');
    try {
      return super.updatePokerPlanningSessionInfo(info);
    } finally {
      _$_PokerPlanningRoomStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
estimate: ${estimate},
pokerPlanningSessionInfo: ${pokerPlanningSessionInfo},
session: ${session},
isMemberOfRoom: ${isMemberOfRoom}
    ''';
  }
}
