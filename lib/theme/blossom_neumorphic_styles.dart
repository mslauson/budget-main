import 'package:flutter_neumorphic/flutter_neumorphic.dart';

///we set colors and depth for things like text and such in here
class BlossomNeumorphicStyles {
  BlossomNeumorphicStyles._();

  static final ten = NeumorphicStyle(
      depth: 10, //customize depth here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final tenWhite = NeumorphicStyle(
      depth: 10, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final eight = NeumorphicStyle(
      depth: 8, //customize depth here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final eightWhite = NeumorphicStyle(
      depth: 8, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final eightGrey = NeumorphicStyle(
      depth: 8, //customize depth here
      color: Colors.grey, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final four = NeumorphicStyle(
      depth: 4, //customize depth here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final fourWhite = NeumorphicStyle(
      depth: 4, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final fourGrey = NeumorphicStyle(
      depth: 4, //customize depth here
      color: Colors.grey, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final three = NeumorphicStyle(
      depth: 3, //customize depth here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final threeWhite = NeumorphicStyle(
      depth: 3, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final two = NeumorphicStyle(
      depth: 2, //customize depth here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final twoWhite = NeumorphicStyle(
      depth: 2, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final twoGrey = NeumorphicStyle(
      depth: 2, //customize depth here
      color: Colors.grey, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final one = NeumorphicStyle(
      depth: 1, //customize depth here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final oneWhite = NeumorphicStyle(
      depth: 1, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final oneGrey = NeumorphicStyle(
      depth: 1, //customize depth here
      color: Colors.grey, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final negativeEightConcave = NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      depth: -8,
      lightSource: LightSource.topRight,
      intensity: .75);

  static final eightConcave = NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: 8,
      lightSource: LightSource.topRight,
      intensity: .75);

  static final eightConvex = NeumorphicStyle(
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: 8,
      lightSource: LightSource.topRight,
      intensity: .75);

  static final eightIconCircle = NeumorphicStyle(
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
      depth: 8,
      lightSource: LightSource.topLeft,
      intensity: .75);

  static final fourIconCircle = NeumorphicStyle(
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
      depth: 4,
      lightSource: LightSource.topLeft,
      intensity: .75);

  static final fourButton = NeumorphicStyle(
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: 4,
      lightSource: LightSource.topLeft,
      intensity: .75);

  static final twentyIconGrey = NeumorphicStyle(
      depth: 20,
      lightSource: LightSource.topLeft,
      intensity: .75,
      color: Colors.grey);
}
