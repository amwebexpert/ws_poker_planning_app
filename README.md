# ws_poker_planning_app

PokerPlanning client native app for the [WsPokerPlanning backend](https://github.com/amwebexpert/ws-poker-planning)

[![made-with-Markdown](https://img.shields.io/badge/Made%20with-Flutter-1389FD.svg)](http://flutter.dev) [![Flutter Responsive](https://img.shields.io/badge/flutter-responsive-brightgreen.svg?style=flat-square)](https://github.com/Codelessly/ResponsiveFramework) ![GitHub last commit](https://img.shields.io/github/last-commit/amwebexpert/guess_the_text) ![GitHub](https://img.shields.io/github/license/amwebexpert/guess_the_text)

## Usefull project commands

### Connect the Android device to localhost backend app running on port 8080

1. start the Flutter app on any Android development device (either emulator or real device)
1. follow the instructions to start the [ws-poker-planning](https://github.com/amwebexpert/ws-poker-planning#full-poker-planning-client-app-and-server-on-localhost) backend
1. issue the following reverse port mapping command:
   adb reverse tcp:8080 tcp:8080

## Deap links on platforms

### Android App links

The app has been associated with the [amwebexpert.users.sourceforge.net](https://amwebexpert.users.sourceforge.net/.well-known/assetlinks.json) domain so here some examples to test the application:

- [App about page](https://amwebexpert.users.sourceforge.net/deep_link_poker_planning_app/about)
- [App settings page](https://amwebexpert.users.sourceforge.net/deep_link_poker_planning_app/settings)

Testing on command line:

    adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://amwebexpert.users.sourceforge.net/deep_link_poker_planning_app/about"'
    adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://amwebexpert.users.sourceforge.net/deep_link_poker_planning_app/settings"'
