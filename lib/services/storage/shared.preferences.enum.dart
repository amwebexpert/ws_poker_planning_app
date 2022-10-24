enum SharedPreferenceKey {
  appLanguage,
  appIsThemeDark,
  lastPokerPlanningRoom,
}

List<String> getAllSharedPreferenceKeys() => SharedPreferenceKey.values.map((e) => e.name).toList();
