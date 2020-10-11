import 'package:flutter_neumorphic/flutter_neumorphic.dart';

///we set colors and depth for things like text and such in here
class BlossomNeumorphicStyles {
  BlossomNeumorphicStyles._();

  static final ten = NeumorphicStyle(
      depth: 10, //customize depth here
      color: Colors.black, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final tenWhite = NeumorphicStyle(
      depth: 10, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight,
      intensity: .75);

  static final four = NeumorphicStyle(
      depth: 4, //customize depth here
      color: Colors.black, //customize color here
      lightSource: LightSource.topRight);

  static final fourWhite = NeumorphicStyle(
      depth: 4, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight);

  static final fourGrey = NeumorphicStyle(
      depth: 4, //customize depth here
      color: Colors.grey, //customize color here
      lightSource: LightSource.topRight);

  static final three = NeumorphicStyle(
      depth: 3, //customize depth here
      color: Colors.black, //customize color here
      lightSource: LightSource.topRight
  );

  static final threeWhite = NeumorphicStyle(
    depth: 3, //customize depth here
    color: Colors.white, //customize color here
      lightSource: LightSource.topRight
  );

  static final two = NeumorphicStyle(
    depth: 2, //customize depth here
    color: Colors.black, //customize color here
      lightSource: LightSource.topRight
  );

  static final twoWhite = NeumorphicStyle(
    depth: 2, //customize depth here
    color: Colors.white, //customize color here
      lightSource: LightSource.topRight
  );

  static final one = NeumorphicStyle(
      depth: 1, //customize depth here
      color: Colors.black, //customize color here
      lightSource: LightSource.topRight
  );

  static final oneWhite = NeumorphicStyle(
      depth: 1, //customize depth here
      color: Colors.white, //customize color here
      lightSource: LightSource.topRight
  );

  static final negativeEightConcave = NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      depth: -8,
      lightSource: LightSource.topRight,
      color: Colors.white
  );

  static final eightConcave = NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: 8,
      lightSource: LightSource.topRight,
      color: Colors.white
  );

  static final eightConvex = NeumorphicStyle(
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: 8,
      lightSource: LightSource.topRight,
      color: Colors.white
  );
}
