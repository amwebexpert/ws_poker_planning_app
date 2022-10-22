import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.model.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';
import 'package:ws_poker_planning_app/theme/width.spacer.widget.dart';
import '../../../utils/extensions/string.extensions.dart';

class PokerOptionsFormWidget extends StatefulWidget {
  const PokerOptionsFormWidget({super.key});

  @override
  State<PokerOptionsFormWidget> createState() => _PokerOptionsFormWidgetState();
}

class _PokerOptionsFormWidgetState extends State<PokerOptionsFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtServerController = TextEditingController();

  CardsListingCategoryName _category = CardsListingCategoryName.fibonnacy;

  @override
  void initState() {
    super.initState();

    _txtServerController.text = 'ws-poker-planning.herokuapp.com';
  }

  @override
  void dispose() {
    _txtServerController.dispose();

    super.dispose();
  }

  void _onCategoryChange(CardsListingCategoryName value) {
    setState(() => _category = value);
  }

  @override
  Widget build(BuildContext context) {
    final isColumnLayout = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(spacing(2)),
        child: Column(
          children: [
            ResponsiveRowColumn(
              rowMainAxisAlignment: MainAxisAlignment.spaceAround,
              layout: isColumnLayout ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: TextFormFieldServerName(controller: _txtServerController),
                ),
                if (!isColumnLayout) const ResponsiveRowColumnItem(child: WidthSpacer()),
                ResponsiveRowColumnItem(
                    rowFlex: 1, child: DropDownButtonFieldCategory(value: _category, onChanged: _onCategoryChange)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownButtonFieldCategory extends StatelessWidget {
  const DropDownButtonFieldCategory({Key? key, required this.value, required this.onChanged}) : super(key: key);

  final CardsListingCategoryName value;
  final void Function(CardsListingCategoryName) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CardsListingCategoryName>(
      items: [
        ...cardsListingCategories.entries.map((entry) => DropdownMenuItem(
              value: entry.key,
              key: ValueKey(entry.key),
              child: Text(entry.value.displayValue, style: Theme.of(context).textTheme.bodyText1),
            ))
      ],
      hint: Text(value.name),
      value: value,
      onChanged: (newValue) => onChanged(newValue ?? value),
    );
  }
}

class TextFormFieldServerName extends StatelessWidget {
  final TextEditingController controller;

  const TextFormFieldServerName({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TextFormField(
      autofocus: controller.text.isBlank,
      enableSuggestions: false,
      autocorrect: false,
      controller: controller,
      validator: (value) => value.isBlank ? localizations.fieldValidationMandatory : null,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(hintText: localizations.serverName),
    );
  }
}