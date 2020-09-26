import 'package:flutter/material.dart';
import 'package:virus_total_api/constants.dart';

import '../../size_config.dart';
class OutputText extends StatelessWidget {
  const OutputText({
    Key key, this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.symmetric(vertical:defaultSize*2),
      child: ClipPath(
        clipper: OutputClipper(),

        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width*.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(.2),
                Colors.blue.withOpacity(.7)
              ]
            ),
          ),
          child: Center(
            child: Text(text, style: TextStyle(
                fontSize: defaultSize*1.7)
            ),
          ),
        ),
      ),
    );
  }
}
class OutputClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double width=size.width;
    double height=size.height;
    double radius = 20;

    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(width-radius, 0)
      ..arcToPoint(Offset(width, radius), radius: Radius.circular(radius), clockwise: false)
      ..lineTo(width, height - radius)
      ..arcToPoint(Offset(width - radius, height),radius: Radius.circular(radius), clockwise: false)
      ..lineTo(radius, height)
      ..arcToPoint(Offset(0, height - radius), radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius), clockwise: false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}