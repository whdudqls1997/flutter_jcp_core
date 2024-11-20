import 'package:flutter/material.dart';

/// Animation enums for [JcpPageRoute].
enum JcpPageAnimations { fade, slideRightToLeft, slideLeftToRight, slideBottomToTop, slideTopToBottom }

/// Animated [MaterialPageRoute].
class JcpPageRoute<T> extends MaterialPageRoute<T> {
  final JcpPageAnimations jcpPageAnimations;
  final Curve animationCurve;
  final Duration animationDuration;

  JcpPageRoute({
    required super.builder,
    required this.jcpPageAnimations,
    this.animationCurve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Duration get transitionDuration => animationDuration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (jcpPageAnimations) {
      case JcpPageAnimations.fade:
        return FadeTransition(
          opacity: animation.drive(
            CurveTween(curve: animationCurve),
          ),
          child: child,
        );
      case JcpPageAnimations.slideRightToLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          )
              .chain(
                CurveTween(curve: animationCurve),
              )
              .animate(animation),
          child: child,
        );
      case JcpPageAnimations.slideLeftToRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          )
              .chain(
                CurveTween(curve: animationCurve),
              )
              .animate(animation),
          child: child,
        );
      case JcpPageAnimations.slideBottomToTop:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          )
              .chain(
                CurveTween(curve: animationCurve),
              )
              .animate(animation),
          child: child,
        );
      case JcpPageAnimations.slideTopToBottom:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          )
              .chain(
                CurveTween(curve: animationCurve),
              )
              .animate(animation),
          child: child,
        );
      default:
        return child;
    }
  }
}
