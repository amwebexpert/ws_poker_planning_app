import 'package:get_it/get_it.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.room.store.dart';
import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.dart';
import 'package:ws_poker_planning_app/features/settings/settings.store.dart';
import 'package:ws_poker_planning_app/services/assets/asset.locator.service.dart';
import 'package:ws_poker_planning_app/services/device/device.info.service.dart';
import 'package:ws_poker_planning_app/services/file/file.service.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/services/storage/shared.preferences.services.dart';
import 'package:ws_poker_planning_app/services/websocket/websocket.service.dart';
import 'package:ws_poker_planning_app/store/app.store.dart';
import 'package:ws_poker_planning_app/utils/animation.utils.dart';
import 'package:ws_poker_planning_app/utils/randomizer.utils.dart';

final serviceLocator = GetIt.instance;

Future<GetIt> initServiceLocator() async {
  serviceLocator
    ..registerSingleton<LoggerService>(LoggerService())
    ..registerSingleton<FileService>(FileService())
    ..registerSingleton<AppStore>(AppStore())
    ..registerSingleton<SharedPreferencesService>(await SharedPreferencesService().init())
    ..registerLazySingleton<DeviceInfoService>(() => DeviceInfoService())
    ..registerLazySingleton<SettingsStore>(() => SettingsStore())
    ..registerLazySingleton<PokerPlanningRoomStore>(() => PokerPlanningRoomStore())
    ..registerLazySingleton<RandomizerUtils>(() => RandomizerUtils())
    ..registerLazySingleton<AssetLocatorService>(() => AssetLocatorService())
    ..registerLazySingleton<AnimationUtils>(() => AnimationUtils(serviceLocator.get<RandomizerUtils>()))
    ..registerFactory<WebSocketService>(() => WebSocketService())
    ..registerFactory<PokerPlanningService>(() => PokerPlanningService());

  await serviceLocator.allReady();

  return serviceLocator;
}
