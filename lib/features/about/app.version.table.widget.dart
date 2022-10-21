import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ws_poker_planning_app/features/about/contributor.model.dart';
import 'package:ws_poker_planning_app/theme/compact.datatable.widget.dart';
import 'package:ws_poker_planning_app/theme/text.link.widget.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';

import 'card.app.connectivity.status.dart';

class AppVersionTable extends StatefulWidget {
  const AppVersionTable({Key? key}) : super(key: key);

  @override
  State<AppVersionTable> createState() => _AppVersionTableState();
}

class _AppVersionTableState extends State<AppVersionTable> {
  String _appVersion = '';
  String _appBuildNumber = '';

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((packageInfo) {
      if (mounted) {
        setState(() {
          _appVersion = packageInfo.version;
          _appBuildNumber = packageInfo.buildNumber;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        CompactDatatableWidget(
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text(localizations.appVersion)),
                DataCell(Text(_appVersion)),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text(localizations.appBuildNumber)),
                DataCell(Text(_appBuildNumber)),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text(localizations.githubProject)),
                const DataCell(
                  ThemedTextLink(
                      displayText: 'Open Source project', hyperlink: 'https://github.com/amwebexpert/guess_the_text'),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text(localizations.connectivityStatus)),
                const DataCell(ConnectivityStatusWidget()),
              ],
            ),
            ...contributors
                .map((contributor) => DataRow(cells: <DataCell>[
                      DataCell(
                        Row(
                          children: [
                            ThemedTextLink(displayText: contributor.name, hyperlink: 'mailto:${contributor.email}'),
                            SizedBox(width: spacing(0.5)),
                            const Icon(Icons.email_outlined),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            ThemedTextLink(displayText: 'Linked-in', hyperlink: contributor.linkedIn),
                            SizedBox(width: spacing(0.5)),
                            const Icon(Icons.person_outline),
                          ],
                        ),
                      )
                    ]))
                .toList(),
          ],
        ),
      ],
    );
  }
}
