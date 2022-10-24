import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.model.dart';
import 'package:ws_poker_planning_app/utils/extensions/string.extensions.dart';

const List<String> pokerPlanningRatingsFibonnaciEnhanced = [
  '?',
  '0',
  '0.5',
  '1',
  '1.5',
  '2',
  '2.5',
  '3',
  '3.5',
  '4',
  '4.5',
  '5',
  '8',
  '13',
  '20',
  '40',
  '100'
];
const List<String> pokerPlanningRatingsFibonnaci = ['?', '0', '1', '2', '3', '5', '8', '13', '20', '40', '100'];
const List<String> pokerPlanningRatingsTShirtSizes = ['?', 'S', 'M', 'L', 'XL'];
const List<String> pokerPlanningRatingsTShirtSizesEnhenced = ['?', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];

enum VotingCardsCategory { fibonnacy, fibonnacyVariant1, tShirt, tShirtVariant1 }

const defaultLocalHostname = 'localhost:8080';

class PokerPlanningSessionInfo {
  final String hostname;
  final String roomUUID;
  final String teamName;
  final String username;
  final VotingCardsCategory votingCategory;

  bool get isSecure => hostname != defaultLocalHostname;

  PokerPlanningSessionInfo(
      {this.hostname = '',
      this.roomUUID = '',
      this.teamName = '',
      this.username = '',
      this.votingCategory = VotingCardsCategory.fibonnacy});

  PokerPlanningSessionInfo.fromJson(Map<String, dynamic> json)
      : hostname = json['hostname'],
        roomUUID = json['roomUUID'],
        teamName = json['teamName'],
        username = json['username'],
        votingCategory = (json['votingCategory'] as String? ?? VotingCardsCategory.fibonnacy.name)
            .toEnum(VotingCardsCategory.values);

  Map<String, dynamic> toJson() => {
        'hostname': hostname,
        'roomUUID': roomUUID,
        'teamName': teamName,
        'username': username,
        'votingCategory': votingCategory.name
      };

  static final Map<String, dynamic> defaultLocalhost = {
    'hostname': defaultLocalHostname,
    'roomUUID': 'default',
    'teamName': 'Localhost-FuegoTeam',
    'username': 'Flutter-LOCALHOST',
    'votingCategory': 'fibonnacy',
  };

  static final Map<String, dynamic> defaultHeroku = {
    'hostname': 'ws-poker-planning.herokuapp.com',
    'roomUUID': 'default',
    'teamName': 'Default-Team',
    'username': 'Andre-Flutter-App',
    'votingCategory': 'fibonnacy',
  };
}

class CardsListingCategory {
  CardsListingCategory({required this.values, required this.displayValue, required this.sorter});

  final List<String> values;
  final String displayValue;
  final int Function(UserEstimate a, UserEstimate b) sorter;
}

final Map<VotingCardsCategory, CardsListingCategory> cardsListingCategories = {
  VotingCardsCategory.fibonnacy: CardsListingCategory(
      displayValue: pokerPlanningRatingsFibonnaci.skip(2).join(' '),
      values: pokerPlanningRatingsFibonnaci,
      sorter: sorterFactory(pokerPlanningRatingsFibonnaci)),
  VotingCardsCategory.fibonnacyVariant1: CardsListingCategory(
      displayValue: pokerPlanningRatingsFibonnaciEnhanced
          .skip(2)
          .map((e) => e.replaceFirst('0.5', '½').replaceFirst('.5', '½'))
          .join(' '),
      values: pokerPlanningRatingsFibonnaciEnhanced,
      sorter: sorterFactory(pokerPlanningRatingsFibonnaciEnhanced)),
  VotingCardsCategory.tShirt: CardsListingCategory(
      displayValue: pokerPlanningRatingsTShirtSizes.skip(1).join(' '),
      values: pokerPlanningRatingsTShirtSizes,
      sorter: sorterFactory(pokerPlanningRatingsTShirtSizes)),
  VotingCardsCategory.tShirtVariant1: CardsListingCategory(
      displayValue: pokerPlanningRatingsTShirtSizesEnhenced.skip(1).join(' '),
      values: pokerPlanningRatingsTShirtSizesEnhenced,
      sorter: sorterFactory(pokerPlanningRatingsTShirtSizesEnhenced)),
};

int Function(UserEstimate a, UserEstimate b) sorterFactory(List<String> valuesArray) {
  return (UserEstimate a, UserEstimate b) =>
      valuesArray.indexOf(a.estimate ?? '?') - valuesArray.indexOf(b.estimate ?? '?');
}
