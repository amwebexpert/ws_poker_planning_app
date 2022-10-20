import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/features/pharmacies/pharmacies.screen.dart';

import 'service.locator.dart';
import 'services/logger/logger.service.dart';

Route? onGenerateRoute(RouteSettings settings) {
  final LoggerService logger = serviceLocator.get();

  Uri uriLink = extractUri(settings);

  switch (uriLink.path) {
    case '/':
      return MaterialPageRoute(builder: (_) => const PharmaciesScreen());

    case '/about':
      return MaterialPageRoute(builder: (_) => const PharmaciesScreen());

    default:
      logger.error('Invalid navigation: ${settings.name}');
      return MaterialPageRoute(builder: (_) => const PharmaciesScreen());
  }
}

Uri extractUri(RouteSettings settings) {
  final LoggerService logger = serviceLocator.get()..info('Navigation to ${settings.name}');
  final uriLink = Uri.parse(settings.name ?? '/');

  if (uriLink.hasQuery) {
    logger.info('Navigation parameters: ${uriLink.queryParameters}');
  }

  return uriLink;
}
