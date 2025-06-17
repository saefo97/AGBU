import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';
class FadeAnimation extends StatelessWidget {
  final int delay;
  final Widget child;

  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
      ..tween(
          'translateY',
          duration: const Duration(milliseconds: 500),
          Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut);
    return CustomAnimationBuilder(
        delay: Duration(milliseconds: delay),
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (BuildContext context, Movie value, Widget? child) {
          return Opacity(
              opacity: value.get("opacity"),
              child: Transform.translate(
                  offset: Offset(0.0, value.get("translateY")), child: child
              )
          );
        });
  }
}