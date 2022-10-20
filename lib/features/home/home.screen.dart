import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poker planning')),
        body:  Center(child: Text('HOME...', style: Theme.of(context).textTheme.headline1))
    );
  }
}
