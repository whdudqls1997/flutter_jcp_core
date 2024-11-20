import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Quick implementation for overriding [ScrollBehavior] so [ScrollGlow] is disabled.
class JcpDisableScrollGlow extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;

  ScrollBehavior get withNone => copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
        scrollbars: false,
        overscroll: false,
      );

  ScrollBehavior get withScrollBar => copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
        scrollbars: true,
        overscroll: false,
      );

  ScrollBehavior get withOverScroll => copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
        scrollbars: false,
        overscroll: true,
      );

  ScrollBehavior get withAll => copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
        scrollbars: true,
        overscroll: true,
      );
}
