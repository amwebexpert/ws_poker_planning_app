import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:ws_poker_planning_app/app.error.widget.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/theme/app.theme.dart';

import 'route.generator.dart';
import 'service.locator.dart';

void main() {
  if (!kDebugMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) => AppErrorWidget(details: details);
  }
  debugRepaintRainbowEnabled = false;

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // for this small POC ok since dependencies are very limited, but in real app we would call initServiceLocator inside the Widget + FutureBuilder
    await initServiceLocator();
    runApp(const MyApp());
  }, (error, stackTrace) {
    LoggerService().error('unhandled error occured in root zone', error: error, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker Planning',
      theme: themeDataDark,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
