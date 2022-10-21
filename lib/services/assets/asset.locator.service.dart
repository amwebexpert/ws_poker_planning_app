import 'package:flutter_svg/flutter_svg.dart';

final Set<String> _animationUniqueNames = Set.unmodifiable([
  '2821-ace-of-cards',
  '44387-man-working-on-computer',
  '49662-success-work',
  '63487-programming-computer',
  '67515-evaluacion',
  '75956-app-development-icon',
  '76888-color-data-analysis',
  '97525-code-dark',
]);

final List<String> _animationNames = List.unmodifiable(_animationUniqueNames.toList(growable: false));

class AssetLocatorService {
  static final AssetLocatorService _instance = AssetLocatorService._privateConstructor();

  static const String assetsFolder = 'assets';

  // animation folders
  static const String animationsFolder = '$assetsFolder/animations';
  static const String loadingAnimFolder = '$animationsFolder/loading';

  // image folders
  static const String imagesFolder = '$assetsFolder/images';
  static const String gameImagesFolder = '$imagesFolder/game';
  static const String backgroundImagesFolder = '$imagesFolder/backgrounds';

  factory AssetLocatorService() => _instance;
  AssetLocatorService._privateConstructor();

  String imagePath(String imageName) => '$imagesFolder/$imageName.svg';

  String loadingAnimationPath(String animationName) => '$loadingAnimFolder/$animationName.json';
  List<String> animationNames() => _animationNames;

  // background images
  String backgroundImagePath(String imageName) => '$backgroundImagesFolder/$imageName.jpg';
  String darkBackgroundImagePath() => backgroundImagePath('background-pexels-pixabay-461940');
  String lightBackgroundImagePath() => backgroundImagePath('beach-sun');

  // gaming images
  String gameImagePath(String imageName) => '$gameImagesFolder/$imageName.svg';
  ExactAssetPicture getPicture(String imageName) =>
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, gameImagePath(imageName));
}
