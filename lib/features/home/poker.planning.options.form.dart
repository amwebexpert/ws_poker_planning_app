import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.model.dart';
import 'package:ws_poker_planning_app/features/home/poker.planning.room.store.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/theme/height.spacer.widget.dart';
import 'package:ws_poker_planning_app/theme/theme.utils.dart';
import 'package:ws_poker_planning_app/theme/width.spacer.widget.dart';
import 'package:ws_poker_planning_app/utils/extensions/string.extensions.dart';

class PokerOptionsFormWidget extends StatefulWidget {
  const PokerOptionsFormWidget({super.key});

  @override
  State<PokerOptionsFormWidget> createState() => _PokerOptionsFormWidgetState();
}

class _PokerOptionsFormWidgetState extends State<PokerOptionsFormWidget> {
  final LoggerService logger = serviceLocator.get();
  final PokerPlanningRoomStore store = serviceLocator.get();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtHostnameController = TextEditingController();
  final TextEditingController _txtTeamNameController = TextEditingController();
  final TextEditingController _txtUsernameController = TextEditingController();

  VotingCardsCategory _votingCategory = VotingCardsCategory.fibonnacy;
  bool isFormPopulated = false;

  @override
  void initState() {
    final sessionInfo = store.pokerPlanningSessionInfo;

    _txtHostnameController
      ..text = sessionInfo.hostname
      ..addListener(updateFormPopulatedFlag);

    _txtTeamNameController
      ..text = sessionInfo.teamName
      ..addListener(updateFormPopulatedFlag);

    _txtUsernameController
      ..text = sessionInfo.username
      ..addListener(updateFormPopulatedFlag);

    _votingCategory = sessionInfo.votingCategory;

    updateFormPopulatedFlag();

    super.initState();
  }

  void updateFormPopulatedFlag() {
    setState(() => isFormPopulated = info.isPopulated);
    store.updatePokerPlanningSessionInfo(info);
  }

  PokerPlanningSessionInfo get info => PokerPlanningSessionInfo(
      hostname: _txtHostnameController.text.trim(),
      roomUUID: 'default',
      teamName: _txtTeamNameController.text.trim(),
      username: _txtUsernameController.text.trim(),
      votingCategory: _votingCategory);

  @override
  void dispose() {
    _txtHostnameController.dispose();
    _txtTeamNameController.dispose();
    _txtUsernameController.dispose();

    super.dispose();
  }

  void _onCategoryChange(VotingCardsCategory value) {
    setState(() => _votingCategory = value);
    store.updatePokerPlanningSessionInfo(info);
  }

  void sessionJoin() {
    if (_formKey.currentState!.validate()) {
      store.join();
    }
  }

  void sessionSharing() {
    if (_formKey.currentState!.validate()) {
      print('share session');
    }
  }

  void sessionCreation() {
    if (_formKey.currentState!.validate()) {
      print('creating session');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final isColumnLayout = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          ResponsiveRowColumn(
            layout: isColumnLayout ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                  rowFlex: 1, child: DropDownButtonFieldCategory(value: _votingCategory, onChanged: _onCategoryChange)),
              if (!isColumnLayout) const ResponsiveRowColumnItem(child: WidthSpacer()),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: TextFormFieldServerName(controller: _txtHostnameController),
              ),
            ],
          ),
          ResponsiveRowColumn(
            layout: isColumnLayout ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(rowFlex: 1, child: TextFormFieldTeamName(controller: _txtTeamNameController)),
              if (!isColumnLayout) const ResponsiveRowColumnItem(child: WidthSpacer()),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: TextFormFieldUsername(controller: _txtUsernameController),
              ),
            ],
          ),
          const HeightSpacer(),
          Observer(builder: (context) {
            return Wrap(
              spacing: spacing(2),
              children: [
                Tooltip(
                  message: localizations.newSessionHint,
                  child: ElevatedButton(
                    onPressed: isFormPopulated ? sessionCreation : null,
                    child: Text(localizations.newSession.toUpperCase()),
                  ),
                ),
                Tooltip(
                  message: localizations.joinHint,
                  child: ElevatedButton(
                    onPressed: isFormPopulated && !store.isMemberOfRoom ? sessionJoin : null,
                    child: Text(localizations.join.toUpperCase()),
                  ),
                ),
                Tooltip(
                  message: localizations.shareHint,
                  child: ElevatedButton(
                    onPressed: isFormPopulated ? sessionSharing : null,
                    child: const Icon(Icons.share),
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}

class DropDownButtonFieldCategory extends StatelessWidget {
  const DropDownButtonFieldCategory({Key? key, required this.value, required this.onChanged}) : super(key: key);

  final VotingCardsCategory value;
  final void Function(VotingCardsCategory) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<VotingCardsCategory>(
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

class TextFormFieldTeamName extends StatelessWidget {
  final TextEditingController controller;

  const TextFormFieldTeamName({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      controller: controller,
      validator: (value) => value.isBlank ? localizations.fieldValidationMandatory : null,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(hintText: localizations.teamName),
    );
  }
}

class TextFormFieldUsername extends StatelessWidget {
  final TextEditingController controller;

  const TextFormFieldUsername({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      controller: controller,
      validator: (value) => value.isBlank ? localizations.fieldValidationMandatory : null,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(hintText: localizations.username),
    );
  }
}
