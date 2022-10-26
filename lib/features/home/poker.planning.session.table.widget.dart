import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.room.store.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';

class PokerPlanningSessionTable extends StatelessWidget {
  const PokerPlanningSessionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final PokerPlanningRoomStore store = serviceLocator.get();

    return Observer(builder: (context) {
      final estimates = store.session?.estimates;

      return store.isSessionStarted
          ? Card(
              child: Padding(
                padding: EdgeInsets.all(spacing(2)),
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: spacing(1),
                    columns: [
                      DataColumn(
                          label: Text(
                        localizations.teamMember,
                        overflow: TextOverflow.ellipsis,
                      )),
                      DataColumn(
                          label: Text(
                            localizations.points,
                            overflow: TextOverflow.ellipsis,
                          ),
                          numeric: true),
                      DataColumn(label: Container(), numeric: true),
                    ],
                    rows: <DataRow>[
                      ...estimates!
                          .map((e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(e.username)),
                                  DataCell(Text(e.estimate ?? '…')),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: spacing(4)),
                                      child: IconButton(
                                        visualDensity: VisualDensity.compact,
                                        icon: const Icon(Icons.delete),
                                        tooltip: localizations.removeUser,
                                        onPressed: () => store.remove(e.username),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(
                            localizations.storyPointsAverage,
                            overflow: TextOverflow.ellipsis,
                          )),
                          const DataCell(Text('15')),
                          DataCell(Container()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const NoSessionStarted();
    });
  }
}

class NoSessionStarted extends StatelessWidget {
  const NoSessionStarted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
