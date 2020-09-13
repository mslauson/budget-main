import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconActionButton extends StatelessWidget {
  final color;
  final iconData;
  final onPressed;

  IconActionButton({
    Key key,
    this.color,
    @required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        type: MaterialType.transparency,
        child: _paintIconActionButton(),
      ),
    );
  }

  Widget _paintIconActionButton() => Center(
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: color ?? Colors.black, width: 2.0),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: FaIcon(iconData),
            color: color ?? Colors.black,
            onPressed: onPressed ?? () => throw NoSuchMethodError,
          ),
        ),
      );
}
