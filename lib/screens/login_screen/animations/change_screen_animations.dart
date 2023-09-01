import 'package:flutter/material.dart';

import '../components/login_content.dart';

class ChangeScreenAnimation {
  static late final AnimationController _topTextController;
  static late final Animation<Offset> topTextAnimation;

  static late final AnimationController _bottomTextController;
  static late final Animation<Offset> bottomTextAnimation;

  static final List<AnimationController> createAccountControllers = [];
  static final List<Animation<Offset>> createAccountAnimations = [];

  static final List<AnimationController> loginControllers = [];
  static final List<Animation<Offset>> loginAnimations = [];

  static var isPlaying = false;
  static var currentScreen = Screens.createAccount;

  static Animation<Offset> _createAnimation({
    required Offset begin,
    required Offset end,
    required AnimationController parent,
  }) {
    return Tween(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: parent,
        curve: Curves.easeInOut,
      ),
    );
  }

  static void initialize({
    required TickerProvider vsync,
    required int createAccountItems,
    required int loginItems,
  }) {
    _topTextController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );

    topTextAnimation = _createAnimation(
      begin: Offset.zero,
      end: const Offset(-1.2, 0),
      parent: _topTextController,
    );

    _bottomTextController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );

    bottomTextAnimation = _createAnimation(
      begin: Offset.zero,
      end: const Offset(0, 1.7),
      parent: _bottomTextController,
    );

    for (var i = 0; i < createAccountItems; i++) {
      createAccountControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      createAccountAnimations.add(
        _createAnimation(
          begin: Offset.zero,
          end: const Offset(-1, 0),
          parent: createAccountControllers[i],
        ),
      );
    }

    for (var i = 0; i < loginItems; i++) {
      loginControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      loginAnimations.add(
        _createAnimation(
          begin: const Offset(1, 0),
          end: Offset.zero,
          parent: loginControllers[i],
        ),
      );
    }
  }

  @override
  void dispose() {
    _topTextController.dispose();
    _bottomTextController.dispose();
    _topTextController.dispose();
    for (final controller in [
      ...createAccountControllers,
      ...loginControllers,
    ]) {
      controller.dispose();
    }
  }

  static Future<void> forward() async {
    isPlaying = true;

    _topTextController.forward();
    await _bottomTextController.forward();

    for (final controller in [
      ...createAccountControllers,
      ...loginControllers,
    ]) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    _bottomTextController.reverse();
    await _topTextController.reverse();

    isPlaying = false;
  }

  static Future<void> reverse() async {
    isPlaying = true;

    _topTextController.forward();
    await _bottomTextController.forward();

    for (final controller in [
      ...loginControllers.reversed,
      ...createAccountControllers.reversed,
    ]) {
      controller.reverse();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    _bottomTextController.reverse();
    await _topTextController.reverse();

    isPlaying = false;
  }
}
