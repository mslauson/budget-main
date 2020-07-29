import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconSso extends StatelessWidget {
  final color;
  final iconData;
  final onPressed;

  IconSso({Key key, this.color, @required this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Ink(
              decoration: BoxDecoration(
                border:
                    Border.all(color: this.color ?? Colors.black, width: 2.0),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: FaIcon(iconData),
                color: this.color ?? Colors.black,
                onPressed: this.onPressed ?? () => throw NoSuchMethodError,
              ),
            ),
          ),
        ));
  }
}
