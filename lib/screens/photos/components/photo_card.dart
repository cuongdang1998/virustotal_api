import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
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
  LikeBloc _likeBloc;
  @override
  void initState() {
    super.initState();
    _likeBloc=BlocProvider.of<LikeBloc>(context);
  }
  _subFindText(String s){
    const String start="https://www.pexels.com/photo/";
    const String end="-";

    final int startindex=start.length;
    final int endindex=s.lastIndexOf(end);

    s=s.substring(startindex,endindex);
    return s;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.defaultSize),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              var findtext=_subFindText(widget.photo.url);
              Navigator.pushNamed(context, "/seephoto/${widget.photo.id}/${findtext}");
              print("You click image ${widget.photo.id} text find ${findtext}");

            },
            child: Hero(
              tag: widget.photo.id,
              child: Container(
                width: double.infinity,
                height: SizeConfig.defaultSize*35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.defaultSize*2.5),
                  image: DecorationImage(
                      image: NetworkImage(widget.photo.src.landscape),
                      fit: BoxFit.cover
                  ),
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
                  leading: BlocBuilder<LikeBloc, LikeState>(
                        builder: (context, state){
                          if(state == LikeState.LikedState){
                            return IconButton(
                              icon:SvgPicture.asset("assets/icons/thumbup.svg", color: kPrimaryColor),
                              onPressed: (){
                                _likeBloc.add(LikeEvent.unliked);
                                print("You like image ${widget.photo.id}");
                              },
                            );
                          }
                          if(state == LikeState.UnLikedState){
                            return IconButton(
                              icon:SvgPicture.asset("assets/icons/thumbup.svg", color: kTextColor),
                              onPressed: (){
                                _likeBloc.add(LikeEvent.liked);
                                print("You like image ${widget.photo.id}");
                              },
                            );
                          }
                        }
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
      ),
    );
  }
}
