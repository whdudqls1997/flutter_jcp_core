import 'dart:math';

import 'package:flutter/material.dart';

extension JcpBuildContext on BuildContext {
  /// Get size of [context].<br>
  /// Throws [Exception] if ancestor is unavailable.
  Size get size => MediaQuery.sizeOf(this);

  /// Get size of [context].<br>
  /// Returns [Null] if not size-able.
  Size? get safeSize {
    try {
      return MediaQuery.sizeOf(this);
    } catch (e) {
      return null;
    }
  }

  /// Get [Orientation] of [context].
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Pop this [context].
  void pop() => Navigator.of(this).pop();
}

extension JcpFlexContainer on Container {
  /// Return this [Container] as a flex version based on given ratio-to-screen.<br>
  /// Smart-sets [width] and [height] based on given ratio.
  Widget flex({required double widthRatio, required double heightRatio}) {
    if (widthRatio > 1.0 || widthRatio <= 0.0 || heightRatio > 1.0 || heightRatio <= 0.0) {
      throw Exception(
        '\n[Flutter_JCP] Failed Assertion Exception'
        '\n[Flutter_JCP] Container.flex(double widthRatio, double heightRatio) :: 0.0 < [widthRatio] < 1.0'
        '\n[Flutter_JCP] Container.flex(double widthRatio, double heightRatio) :: 0.0 < [heightRatio] < 1.0',
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // is not square
        double targetWidth = constraints.maxWidth * widthRatio;
        double targetHeight = constraints.maxWidth * heightRatio;

        // return
        return Container(
          alignment: alignment,
          padding: padding,
          color: color,
          decoration: decoration,
          foregroundDecoration: foregroundDecoration,
          width: targetWidth,
          height: targetHeight,
          constraints: null,
          margin: margin,
          transform: transform,
          transformAlignment: transformAlignment,
          clipBehavior: clipBehavior,
          child: child,
        );
      },
    );
  }
}

extension JcpFlexText on Text {
  /// Return this [Text] as a flex version based on given ratio-to-screen.<br>
  /// Smart-sets [fontSize] based on given ratio.
  Widget flex({required double ratio}) {
    if (ratio > 1.0 || ratio <= 0.0) {
      throw Exception(
        '\n[Flutter_JCP] Failed Assertion Exception'
        '\n[Flutter_JCP] Text.flex(double ratio) :: 0.0 < [ratio] < 1.0',
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // is square
        double targetSize = min(constraints.maxWidth, constraints.maxHeight) * ratio;

        // if forced infinite size
        if (targetSize.isInfinite) {
          throw Exception(
            '\n[Flutter_JCP] Infinite Size Exception'
            '\n[Flutter_JCP] Given BoxConstraint forces infinite size on Text',
          );
        }

        // return
        return Text(
          data ?? '',
          style: style == null ? TextStyle(fontSize: targetSize) : style!.copyWith(fontSize: targetSize),
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );
      },
    );
  }
}

extension JcpFlexIcon on Icon {
  /// Return this [Icon] as a flex version based on given ratio-to-screen.<br>
  /// Smart-sets [Size] based on given ratio.
  Widget flex({required double ratio}) {
    if (ratio > 1.0 || ratio <= 0.0) {
      throw Exception(
        '\n[Flutter_JCP] Failed Assertion Exception'
        '\n[Flutter_JCP] Icon.flex(double ratio) :: 0.0 < [ratio] < 1.0',
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // is square
        double targetSize = min(constraints.maxWidth, constraints.maxHeight) * ratio;

        // if forced infinite size
        if (targetSize.isInfinite) {
          throw Exception(
            '\n[Flutter_JCP] Infinite Size Exception'
            '\n[Flutter_JCP] Given BoxConstraint forces infinite size on Icon',
          );
        }

        // return
        return Icon(
          icon,
          size: targetSize,
          fill: fill,
          weight: weight,
          grade: grade,
          opticalSize: opticalSize,
          color: color,
          shadows: shadows,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
      },
    );
  }
}
