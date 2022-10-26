# ws_poker_planning_app

Flutter PokerPlanning client app

## Usefull commands

### Connect the Android device to localhost backend app running on port 8080

1. start the Flutter app on any Android development device (either emulator or real device)
1. follow the instructions to start the [ws-poker-planning](https://github.com/amwebexpert/ws-poker-planning#full-poker-planning-client-app-and-server-on-localhost) backend
1. issue the following reverse port mapping command:
   adb reverse tcp:8080 tcp:8080
