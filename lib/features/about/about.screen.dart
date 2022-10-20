import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poker planning - About...')),
        body:  Center(child: Text('ABOUT...', style: Theme.of(context).textTheme.headline1))
    );
  }
}
