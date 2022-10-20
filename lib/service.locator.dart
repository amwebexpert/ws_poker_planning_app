import 'package:get_it/get_it.dart';
import 'package:ws_poker_planning_app/store/app.store.dart';

import 'services/file/file.service.dart';
import 'services/logger/logger.service.dart';

final serviceLocator = GetIt.instance;

Future<GetIt> initServiceLocator() async {
  serviceLocator
    ..registerSingleton<LoggerService>(LoggerService())
    ..registerSingleton<FileService>(FileService())
    ..registerSingleton<AppStore>(AppStore());

  await serviceLocator.allReady();

  return serviceLocator;
}
