import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.options.form.dart';
import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/theme/app.menu.widget.dart';

// TODOS
// pass all form values as params to PokerOptionsFormWidget (allows to handle multiple poker sessions)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoggerService logger = serviceLocator.get();
  final PokerPlanningService webSocketService = serviceLocator.get();

  @override
  void initState() {
    super.initState();

    webSocketService
      ..startSession(hostname: 'ws-poker-planning.herokuapp.com', roomUUID: 'e78caaee-a1a2-4298-860d-81d7752226ae', isSecure: true)
      ..sendMessage();

    webSocketService.stream.listen((session) {
      logger.info('Receiving PokerPlanningSession instance: ${session.toJson()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(title: Text(localizations.appTitle)),
        drawer: const Drawer(child: AppMenu()),
        body: SingleChildScrollView(
            child: Column(
          children: const [PokerOptionsFormWidget()],
        )));
  }
}
