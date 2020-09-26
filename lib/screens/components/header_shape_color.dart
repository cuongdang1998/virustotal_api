import 'package:flutter/material.dart';

import '../../constants.dart';
class HeaderShapeColor extends StatelessWidget {
  const HeaderShapeColor({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderShapeColorClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height*.3,
        decoration: BoxDecoration(

            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPrimaryColor.withOpacity(.5),
                  kPrimaryColor.withOpacity(.1),
                ]
            )
        ),
      ),
    );
  }
}

class HeaderShapeColorClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double width=size.width;
    double height=size.height;
    var path=Path()..lineTo(0, height*.7)
      ..quadraticBezierTo(width/2, height, width, height*.7)
      ..lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}