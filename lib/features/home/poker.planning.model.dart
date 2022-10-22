import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.model.dart';

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

enum CardsListingCategoryName { fibonnacy, fibonnacyVariant1, tShirt, tShirtVariant1 }

class CardsListingCategory {
  CardsListingCategory({required this.values, required this.displayValue, required this.sorter});

  List<String> values;
  String displayValue;
  int Function(UserEstimate a, UserEstimate b) sorter;
}

final Map<CardsListingCategoryName, CardsListingCategory> cardsListingCategories = {
  CardsListingCategoryName.fibonnacy: CardsListingCategory(
      displayValue: pokerPlanningRatingsFibonnaci.skip(2).join(' '),
      values: pokerPlanningRatingsFibonnaci,
      sorter: sorterFactory(pokerPlanningRatingsFibonnaci)),
  CardsListingCategoryName.fibonnacyVariant1: CardsListingCategory(
      displayValue: pokerPlanningRatingsFibonnaciEnhanced
          .skip(2)
          .map((e) => e.replaceFirst('0.5', '½').replaceFirst('.5', '½'))
          .join(' '),
      values: pokerPlanningRatingsFibonnaciEnhanced,
      sorter: sorterFactory(pokerPlanningRatingsFibonnaciEnhanced)),
  CardsListingCategoryName.tShirt: CardsListingCategory(
      displayValue: pokerPlanningRatingsTShirtSizes.skip(1).join(' '),
      values: pokerPlanningRatingsTShirtSizes,
      sorter: sorterFactory(pokerPlanningRatingsTShirtSizes)),
  CardsListingCategoryName.tShirtVariant1: CardsListingCategory(
      displayValue: pokerPlanningRatingsTShirtSizesEnhenced.skip(1).join(' '),
      values: pokerPlanningRatingsTShirtSizesEnhenced,
      sorter: sorterFactory(pokerPlanningRatingsTShirtSizesEnhenced)),
};

int Function(UserEstimate a, UserEstimate b) sorterFactory(List<String> valuesArray) {
  return (UserEstimate a, UserEstimate b) =>
      valuesArray.indexOf(a.estimate ?? '?') - valuesArray.indexOf(b.estimate ?? '?');
}
