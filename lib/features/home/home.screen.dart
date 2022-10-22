import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.options.form.dart';
import 'package:ws_poker_planning_app/theme/app.menu.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
