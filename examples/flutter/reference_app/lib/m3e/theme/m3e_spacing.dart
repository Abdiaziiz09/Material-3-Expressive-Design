// Copyright 2026 The Flutter M3E Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// Normative M3E Spacing Tokens based on the 8dp baseline and 4dp micro-grid.
///
/// In Material 3 Expressive, layout bounds, margins, and gaps must strictly
/// reference these tokens. Magic numbers are strictly forbidden.
@immutable
class M3ESpacing {
  const M3ESpacing({
    this.space2 = 2.0,
    this.space4 = 4.0,
    this.space8 = 8.0,
    this.space12 = 12.0,
    this.space16 = 16.0,
    this.space20 = 20.0,
    this.space24 = 24.0,
    this.space32 = 32.0,
    this.space40 = 40.0,
    this.space48 = 48.0,
    this.space64 = 64.0,
  });

  /// Micro-spacing for tight alignments (2dp).
  final double space2;

  /// Micro-spacing for icon-to-label gaps and badge offsets (4dp).
  final double space4;

  /// Tight padding between inline items, chips, and small controls (8dp).
  final double space8;

  /// Compact padding inside list tiles and compact card headers (12dp).
  final double space12;

  /// Standard screen margins on compact viewports and card padding (16dp).
  final double space16;

  /// Generous card padding and content grouping (20dp).
  final double space20;

  /// Section spacing and tablet content margins (24dp).
  final double space24;

  /// Major block separation and hero section gaps (32dp).
  final double space32;

  /// Extra large sectional spacing (40dp).
  final double space40;

  /// Large-screen breathing room and tablet margins (48dp).
  final double space48;

  /// Hero container vertical padding and splash spacing (64dp).
  final double space64;

  // Convenience EdgeInsets
  EdgeInsets get all4 => EdgeInsets.all(space4);
  EdgeInsets get all8 => EdgeInsets.all(space8);
  EdgeInsets get all12 => EdgeInsets.all(space12);
  EdgeInsets get all16 => EdgeInsets.all(space16);
  EdgeInsets get all20 => EdgeInsets.all(space20);
  EdgeInsets get all24 => EdgeInsets.all(space24);
  EdgeInsets get all32 => EdgeInsets.all(space32);

  EdgeInsets get horizontal16 => EdgeInsets.symmetric(horizontal: space16);
  EdgeInsets get horizontal24 => EdgeInsets.symmetric(horizontal: space24);
  EdgeInsets get vertical8 => EdgeInsets.symmetric(vertical: space8);
  EdgeInsets get vertical12 => EdgeInsets.symmetric(vertical: space12);
  EdgeInsets get vertical16 => EdgeInsets.symmetric(vertical: space16);

  EdgeInsets get symmetricH16V8 => EdgeInsets.symmetric(horizontal: space16, vertical: space8);
  EdgeInsets get symmetricH16V12 => EdgeInsets.symmetric(horizontal: space16, vertical: space12);
  EdgeInsets get symmetricH24V16 => EdgeInsets.symmetric(horizontal: space24, vertical: space16);

  M3ESpacing copyWith({
    double? space2,
    double? space4,
    double? space8,
    double? space12,
    double? space16,
    double? space20,
    double? space24,
    double? space32,
    double? space40,
    double? space48,
    double? space64,
  }) {
    return M3ESpacing(
      space2: space2 ?? this.space2,
      space4: space4 ?? this.space4,
      space8: space8 ?? this.space8,
      space12: space12 ?? this.space12,
      space16: space16 ?? this.space16,
      space20: space20 ?? this.space20,
      space24: space24 ?? this.space24,
      space32: space32 ?? this.space32,
      space40: space40 ?? this.space40,
      space48: space48 ?? this.space48,
      space64: space64 ?? this.space64,
    );
  }

  static M3ESpacing lerp(M3ESpacing a, M3ESpacing b, double t) {
    return M3ESpacing(
      space2: _lerpDouble(a.space2, b.space2, t),
      space4: _lerpDouble(a.space4, b.space4, t),
      space8: _lerpDouble(a.space8, b.space8, t),
      space12: _lerpDouble(a.space12, b.space12, t),
      space16: _lerpDouble(a.space16, b.space16, t),
      space20: _lerpDouble(a.space20, b.space20, t),
      space24: _lerpDouble(a.space24, b.space24, t),
      space32: _lerpDouble(a.space32, b.space32, t),
      space40: _lerpDouble(a.space40, b.space40, t),
      space48: _lerpDouble(a.space48, b.space48, t),
      space64: _lerpDouble(a.space64, b.space64, t),
    );
  }

  static double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
