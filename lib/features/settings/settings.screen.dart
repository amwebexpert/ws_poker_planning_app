import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ws_poker_planning_app/theme/app.bar.title.widget.dart';

import '/features/settings/hero.settings.widget.dart';
import '/theme/theme.utils.dart';
import '../../service.locator.dart';
import '../../services/assets/asset.locator.service.dart';
import 'brightness.settings.widget.dart';
import 'language.settings.widget.dart';
import 'settings.store.dart';

class SettingsScreen extends StatelessWidget {
  final AssetLocatorService assetLocatorService = serviceLocator.get();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final SettingsStore settings = serviceLocator.get();

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: localizations.preferences),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: spacing(1)),
          child: Column(
            children: <Widget>[
              HeroSettingsWidget(),
              const LanguageSettingWidget(),
              const Divider(),
              const BrightnessSettingWidget(),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class BackDemoWidget extends StatelessWidget {
  const BackDemoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(color: Colors.orange),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(Icons.settings_applications, size: 200), Text('Hidden settings goes here!')],
        )),
      );
}
