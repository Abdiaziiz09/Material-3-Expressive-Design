import 'package:flutter/material.dart';

/// Documentation sample tokens; these values are project choices, not
/// authoritative Material tokens.
class M3ETokens {
  const M3ETokens();

  final spacing = const M3ESpacing();
  final shapes = const M3EShapes();
}

extension M3EBuildContext on BuildContext {
  M3ETokens get m3e => const M3ETokens();
}

class M3ESpacing {
  const M3ESpacing();

  double get space2 => 2;
  double get space4 => 4;
  double get space8 => 8;
  double get space12 => 12;
  double get space16 => 16;
  double get space20 => 20;
  double get space24 => 24;
  double get space32 => 32;
  double get space40 => 40;
  double get space48 => 48;
  double get space64 => 64;

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
  EdgeInsets get symmetricH16V8 =>
      EdgeInsets.symmetric(horizontal: space16, vertical: space8);
  EdgeInsets get symmetricH16V12 =>
      EdgeInsets.symmetric(horizontal: space16, vertical: space12);
  EdgeInsets get symmetricH24V16 =>
      EdgeInsets.symmetric(horizontal: space24, vertical: space16);
}

class M3EShapes {
  const M3EShapes();

  double get radiusNone => 0;
  double get radiusExtraSmall => 4;
  double get radiusSmall => 8;
  double get radiusMedium => 12;
  double get radiusLarge => 16;
  double get radiusExtraLarge => 28;
  double get radiusFull => 999;

  BorderRadius get borderNone => BorderRadius.circular(radiusNone);
  BorderRadius get borderExtraSmall => BorderRadius.circular(radiusExtraSmall);
  BorderRadius get borderSmall => BorderRadius.circular(radiusSmall);
  BorderRadius get borderMedium => BorderRadius.circular(radiusMedium);
  BorderRadius get borderLarge => BorderRadius.circular(radiusLarge);
  BorderRadius get borderExtraLarge => BorderRadius.circular(radiusExtraLarge);
  BorderRadius get borderFull => BorderRadius.circular(radiusFull);
}
