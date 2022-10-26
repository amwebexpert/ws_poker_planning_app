import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.room.store.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/theme/dialogs/confirm.dialog.widget.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';
import 'package:ws_poker_planning_app/theme/width.spacer.widget.dart';

class PokerPlanningSessionTable extends StatefulWidget {
  const PokerPlanningSessionTable({Key? key}) : super(key: key);

  @override
  State<PokerPlanningSessionTable> createState() => _PokerPlanningSessionTableState();
}

class _PokerPlanningSessionTableState extends State<PokerPlanningSessionTable> {
  final PokerPlanningRoomStore store = serviceLocator.get();
  bool _isVisible = false;

  void _toggleVisibility() => setState(() => _isVisible = !_isVisible);

  void _clearAllVotes() {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    showConfirmDialog(
        context: context,
        title: localizations.dialogTitleConfirm,
        body: localizations.clearAllVotesQuestion,
        onConfirm: () => store.reset());
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Observer(builder: (context) {
      final estimates = store.session?.estimates;
      final hasAtLeastOneVote = store.session?.hasAtLeastOneVote ?? false;

      return store.isSessionStarted
          ? Card(
              child: Padding(
                padding: EdgeInsets.all(spacing(2)),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tooltip(
                            message: localizations.clearAllVotes,
                            child: ElevatedButton(
                                onPressed: hasAtLeastOneVote ? _clearAllVotes : null, child: const Icon(Icons.delete)),
                          ),
                          const WidthSpacer(
                            spacingUnitCount: 2,
                          ),
                          Tooltip(
                            message: localizations.toggleStoryPointsVisibility,
                            child: ElevatedButton(
                              onPressed: hasAtLeastOneVote ? _toggleVisibility : null,
                              child: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                        ],
                      ),
                      DataTable(
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
                          ...estimates!.map((e) {
                            final valueWhenVisible = e.estimate ?? '…';
                            final valueWhenHidden = e.hasEstimate ? '✔' : '…';

                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text(e.username)),
                                DataCell(Text(_isVisible ? valueWhenVisible : valueWhenHidden)),
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
                            );
                          }).toList(),
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
