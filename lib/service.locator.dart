import 'package:get_it/get_it.dart';
import 'package:ws_poker_planning_app/features/settings/settings.store.dart';
import 'package:ws_poker_planning_app/services/assets/asset.locator.service.dart';
import 'package:ws_poker_planning_app/services/file/device/device.info.service.dart';
import 'package:ws_poker_planning_app/services/file/storage/shared.preferences.services.dart';
import 'package:ws_poker_planning_app/store/app.store.dart';
import 'package:ws_poker_planning_app/utils/animation.utils.dart';
import 'package:ws_poker_planning_app/utils/randomizer.utils.dart';

import 'services/file/file.service.dart';
import 'services/logger/logger.service.dart';

final serviceLocator = GetIt.instance;

Future<GetIt> initServiceLocator() async {
  serviceLocator
    ..registerSingleton<LoggerService>(LoggerService())
    ..registerSingleton<FileService>(FileService())
    ..registerSingleton<AppStore>(AppStore())
    ..registerSingleton<SharedPreferencesService>(await SharedPreferencesService().init())
    ..registerLazySingleton<DeviceInfoService>(() => DeviceInfoService())
    ..registerLazySingleton<SettingsStore>(() => SettingsStore())
    ..registerLazySingleton<RandomizerUtils>(() => RandomizerUtils())
    ..registerLazySingleton<AssetLocatorService>(() => AssetLocatorService())
    ..registerLazySingleton<AnimationUtils>(() => AnimationUtils(serviceLocator.get<RandomizerUtils>()));

  await serviceLocator.allReady();

  return serviceLocator;
}
