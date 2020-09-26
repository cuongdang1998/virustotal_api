import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/models/photos/photo.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class PhotoCard extends StatefulWidget {
  const PhotoCard({
    Key key, this.photo,
  }): super(key: key);
  final Photo photo;
  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/seephoto/${widget.photo.id}");
            print("You click image ${widget.photo.id}");
          },
          child: Container(
            width: double.infinity,
            height: SizeConfig.defaultSize*35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.defaultSize*2.5),
              image: DecorationImage(
                  image: NetworkImage(widget.photo.src.tiny),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              height: SizeConfig.defaultSize*6,
              width: double.infinity,
              //padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(SizeConfig.defaultSize*2.5),
                      bottomRight: Radius.circular(SizeConfig.defaultSize*2.5)
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0,5),
                        color: kTextColor.withOpacity(.3),
                        blurRadius: 20
                    )
                  ]
              ),
              child: ListTile(
                leading: IconButton(
                  icon: SvgPicture.asset("assets/icons/thumbup.svg",
                    color: widget.photo.liked ? kPrimaryColor : kTextColor,
                  ),
                  onPressed: (){
                    print("You like image ${widget.photo.id}");
                  },
                ),
                title: Text(widget.photo.photographer, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.defaultSize*1.7),
                ),
                trailing:  CircleAvatar(
                ),
              )
          ),
        ),
        //SizedBox(height: SizeConfig.defaultSize,)
      ],
    );
  }
}
