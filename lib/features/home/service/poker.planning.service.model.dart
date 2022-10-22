class PokerPlanningSession {
  PokerPlanningSession({
    required this.version,
    required this.lastUpdateIso8601,
    required this.estimates,
  });

  String version;
  String lastUpdateIso8601;
  List<UserEstimate> estimates;
}

class UserEstimate {
  UserEstimate({required this.username, this.estimate, this.estimatedAtIso8601});

  String username;
  String? estimate;
  String? estimatedAtIso8601;
}

enum MessageType { reset, vote, remove }

class UserMessage<TPayload> {
  UserMessage({required this.type, this.payload});

  MessageType type;
  TPayload? payload;
}
