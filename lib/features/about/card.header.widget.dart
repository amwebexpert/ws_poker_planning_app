import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'card.header.animation.widget.dart';
import 'privacy.policy.widget.dart';

class CardHeaderWidget extends StatelessWidget {
  const CardHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.info_outline_rounded),
          title: const HeaderlineWidget(),
          subtitle: Text(
            localizations.appSubTitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const CardHeaderAnimation(),
        const PrivacyPolicyWidget(),
      ],
    );
  }
}

class HeaderlineWidget extends StatelessWidget {
  const HeaderlineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Text(localizations.appTitle, style: Theme.of(context).textTheme.headline5,);
  }
}
