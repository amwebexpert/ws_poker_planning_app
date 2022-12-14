import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ws_poker_planning_app/theme/app.bar.title.widget.dart';

import '/theme/theme.utils.dart';
import '../../service.locator.dart';
import '../../services/assets/asset.locator.service.dart';
import 'card.widget.dart';

const isPortraitOrientationLocked = false; // TODO Create a preferences for this feature

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String backgroundImage = serviceLocator.get<AssetLocatorService>().darkBackgroundImagePath();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    if (isPortraitOrientationLocked) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values.toList());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: AppBarTitle(title: localizations.about),
        ),
        body: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Padding(
              padding: EdgeInsets.all(spacing(3)),
              child: const AboutCard(),
            ),
          ));
  }
}
