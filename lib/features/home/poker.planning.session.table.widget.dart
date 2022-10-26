import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokerPlanningSessionTable extends StatelessWidget {
  const PokerPlanningSessionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: DataTable(
        horizontalMargin: 0,
        columns: [
          DataColumn(label: Text(localizations.teamMember)),
          DataColumn(label: Text(localizations.points)),
        ],
        rows: <DataRow>[
          const DataRow(
            cells: <DataCell>[
              DataCell(Text('John Doe')),
              DataCell(Text('5')),
            ],
          ),
          const DataRow(
            cells: <DataCell>[
              DataCell(Text('Mary Higgins')),
              DataCell(Text('7')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(localizations.storyPointsAverage)),
              const DataCell(Text('15')),
            ],
          ),
        ],
      ),
    );
  }
}
