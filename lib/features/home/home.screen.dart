import 'package:flutter/material.dart';
import 'package:ws_poker_planning_app/theme/app.menu.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poker planning')),
          drawer: const Drawer(child: AppMenu()),
        body:  Center(child: Text('HOME...', style: Theme.of(context).textTheme.headline1))
    );
  }
}
