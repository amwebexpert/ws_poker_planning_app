import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/service.locator.dart';
import '/services/logger/logger.service.dart';
import '/utils/animation.utils.dart';

class CardHeaderAnimation extends StatefulWidget {
  const CardHeaderAnimation({Key? key}) : super(key: key);

  @override
  State<CardHeaderAnimation> createState() => _CardHeaderAnimationState();
}

class _CardHeaderAnimationState extends State<CardHeaderAnimation> {
  final LoggerService logger = serviceLocator.get();
  final AnimationUtils animationUtils = serviceLocator.get();
  late String _assetAnimation;

  @override
  void initState() {
    super.initState();
    _assetAnimation = animationUtils.getAnimationPath();
  }

  void _updateAnimation() {
    final newAnimation = animationUtils.getAnimationPath();
    logger.info('asset animation: [$newAnimation]');
    setState(() => _assetAnimation = newAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _updateAnimation,
      child: SizedBox(
          width: 200,
          child: Center(
            child: Lottie.asset(_assetAnimation),
          )),
    );
  }
}
