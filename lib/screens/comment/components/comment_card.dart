
import 'package:flutter/material.dart';
import 'package:virus_total_api/models/comments.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key key, this.press, this.comment,
  }) : super(key: key);
  final Function press;
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    var defaultsize=SizeConfig.defaultSize;
    return GestureDetector(
      onTap: press,
      child: ClipPath(
        clipper: CommentClipper(),
        child: Container(
          padding: EdgeInsets.only(left: defaultsize, top: defaultsize,
              bottom: defaultsize*4, right: defaultsize),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.withOpacity(.1),
                  Colors.cyanAccent.withOpacity(.1),
                  Colors.blue.withOpacity(.5),
                ]
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Comment", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: defaultsize*1.8
                  )),
                ),
                Text("${comment.commentcontent}",
                  //overflow: TextOverflow.ellipsis,
                  maxLines: 10, style: TextStyle(
                      fontSize: defaultsize*1.6
                  ),),
                Align(
                  alignment: Alignment.center,
                  child: Text("Time",
                      style: TextStyle(color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultsize*1.8
                      )
                  ),
                ),
                Text("${comment.date}",
                    style: TextStyle(color: kTextColor,
                        fontSize: defaultsize*1.6
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CommentClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=Path();
    double width=size.width;
    double height=size.height;
    double cornerside=SizeConfig.defaultSize;
    path.lineTo(0, height-cornerside*6);
    path.quadraticBezierTo(0, height-cornerside*3, width-cornerside*7, height-cornerside*3);
    path.lineTo( width-cornerside*10, height);
    path.lineTo( width-cornerside*10, height-cornerside*3);
    path.lineTo( width-cornerside*5, height-cornerside*3);
    path.quadraticBezierTo(width, height-cornerside*3, width, height-cornerside*8);
    path.lineTo(width, cornerside*3);
    path.quadraticBezierTo(width, 0, width-cornerside*6, 0);
    path.lineTo(width, 0);
    path.lineTo(cornerside*6, 0);
    path.quadraticBezierTo(0, 0, 0, cornerside*3);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}