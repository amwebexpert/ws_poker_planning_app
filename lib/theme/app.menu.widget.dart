import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ws_poker_planning_app/theme/app.menu.item.widget.dart';
import 'package:ws_poker_planning_app/theme/menu.logo.widget.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        MenuLogo(),
        MenuItemWidget(
          titleLabel: localizations.preferences,
          iconName: 'preferences',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings');
          },
        ),
        MenuItemWidget(
          titleLabel: localizations.about,
          iconName: 'info',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/about');
          },
        ),
      ],
    );
  }
}
