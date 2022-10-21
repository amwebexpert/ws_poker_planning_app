import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ws_poker_planning_app/app.error.widget.dart';
import 'package:ws_poker_planning_app/features/settings/settings.store.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/theme/app.theme.dart';
import 'package:ws_poker_planning_app/utils/animation.utils.dart';
import 'package:ws_poker_planning_app/utils/randomizer.utils.dart';

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
    runApp(const PokerPlanningApp());
  }, (error, stackTrace) {
    LoggerService().error('unhandled error occured in root zone', error: error, stackTrace: stackTrace);
  });
}

class PokerPlanningApp extends StatefulWidget {
  const PokerPlanningApp({Key? key}) : super(key: key);

  @override
  State<PokerPlanningApp> createState() => _PokerPlanningAppState();
}

class _PokerPlanningAppState extends State<PokerPlanningApp> {
  bool _isAppLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData());
  }

  Future<void> loadData() async {
    // TODO data loading here
    await Future.delayed(const Duration(seconds: 2));

    // ensure the widget was not removed from the tree while the asynchronous call was in flight
    if (mounted) {
      setState(() => _isAppLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAppLoading) {
      return Center(
        child: Lottie.asset(AnimationUtils(RandomizerUtils()).getAnimationPath()),
      );
    }

    final SettingsStore settingsStore = serviceLocator.get<SettingsStore>();

    return Observer(builder: (BuildContext context) {
      return MaterialApp(
        // debugShowCheckedModeBanner: false, // uncomment to take screen captures without the banner
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: settingsStore.locale,
        theme: themeDataLight,
        darkTheme: themeDataDark,
        themeMode: settingsStore.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          backgroundColor: Colors.black,
          breakpoints: const [
            ResponsiveBreakpoint.resize(576, name: MOBILE),
            ResponsiveBreakpoint.resize(768, name: TABLET),
            ResponsiveBreakpoint.resize(992, name: DESKTOP),
          ],
        ),
      );
    });
  }
}
