import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/theme/blossom_text.dart';

class DrawerContainer extends StatefulWidget {
  final List<Widget> children;

  DrawerContainer({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  double offsetX;
  double offsetY;
  double scaleFactor;
  bool isDrawerOpen;

  @override
  void initState() {
    super.initState();

    offsetX = 0;
    offsetY = 0;
    scaleFactor = 1;
    isDrawerOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _resetView(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 225),
        transform: Matrix4.translationValues(offsetX, offsetY, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        curve: Curves.easeInOutCirc,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
          boxShadow: [
            BoxShadow(blurRadius: 100, spreadRadius: 25, color: Colors.black12, offset: Offset(-25, 0))
          ]
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChevronButton(),
                  Text('Blossom', style: BlossomText.title),
                  CircleAvatar(backgroundColor: Colors.black)
                ],
              ),
            ),
            Column(
              children: widget.children
                    .map((e) => Padding(padding: EdgeInsets.all(5), child: e))
                    .toList())
          ],
        ),
      ),
    );
  }

  void _resetView() {
    if (isDrawerOpen) {
      setState(() {
        offsetX = 0;
        offsetY = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });
    }
  }

  IconButton _buildChevronButton() => isDrawerOpen
      ? IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
          color: Colors.black,
          onPressed: () => _resetView())
      : IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronRight),
          color: Colors.black,
          onPressed: () => {
            setState(() {
              offsetX = 250;
              offsetY = 160;
              scaleFactor = 0.65;
              isDrawerOpen = !isDrawerOpen;
            })
          },
        );
}
