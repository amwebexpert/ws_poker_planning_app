class PokerPlanningSession {
  PokerPlanningSession({
    required this.version,
    required this.lastUpdateISO8601,
    required this.estimates,
  });

  late final String version;
  late final String lastUpdateISO8601;
  late final List<UserEstimate> estimates;

  bool hasMember(String username) => estimates.any((estimate) => estimate.username == username);

  PokerPlanningSession.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    lastUpdateISO8601 = json['lastUpdateISO8601'];
    final List estimateItems = json['estimates'] as List? ?? [];
    estimates = estimateItems.map((dynamic e) => UserEstimate.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'lastUpdateISO8601': lastUpdateISO8601,
        'estimates': estimates.map((UserEstimate e) => e.toJson()).toList(),
      };

  bool get hasAtLeastOneVote => estimates.any((element) => element.estimate != null);
}

class UserEstimate extends SerializableAsJson {
  UserEstimate({required this.username, this.estimate, this.estimatedAtISO8601});

  String username;
  String? estimate;
  String? estimatedAtISO8601;

  bool get hasEstimate => estimate != null;

  UserEstimate.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        estimate = json['estimate'],
        estimatedAtISO8601 = json['estimatedAtISO8601'];

  @override
  Map<String, dynamic> toJson() => {
        'username': username,
        'estimate': estimate,
        'estimatedAtISO8601': estimatedAtISO8601,
      };
}

enum MessageType { reset, vote, remove }

abstract class SerializableAsJson {
  Map<String, dynamic> toJson();
}

class UserMessage<TPayload extends SerializableAsJson> {
  UserMessage({required this.type, this.payload});

  MessageType type;
  TPayload? payload;

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'payload': payload?.toJson(),
      };
}
