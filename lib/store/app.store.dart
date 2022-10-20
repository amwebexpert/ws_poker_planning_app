import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:ws_poker_planning_app/services/file/directory.enum.dart';
import 'package:ws_poker_planning_app/services/file/file.service.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';

import '../service.locator.dart';

// Include generated file
part 'app.store.g.dart';

// This is the class used by rest of the codebase
class AppStore = AppStoreBase with _$AppStore;

// The store-class
abstract class AppStoreBase with Store {
  final LoggerService loggerService = serviceLocator.get();
  final FileService fileService = serviceLocator.get();

  @observable
  ObservableMap<String, List<String>> orders = ObservableMap.of({});

  @action
  void addOrder({required String pharmacyId, required List<String> medicaments}) {
    orders[pharmacyId] = medicaments;
    String data = json.encode(orders);

    const filename = 'orders.json';
    fileService.write(data: data, filename: filename, directoryType: DirectoryType.appSupport).then((file) {
      loggerService.info('stored orders info into ${file.uri}');
    }).onError((error, stackTrace) {
      const message = 'Error occured while storing orders info into $filename';
      loggerService.error(message, error: error, stackTrace: stackTrace);
    });
  }

  bool hasOrderFor(String pharmacyId) => orders.containsKey(pharmacyId);
}
