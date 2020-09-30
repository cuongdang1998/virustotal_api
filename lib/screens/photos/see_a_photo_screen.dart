import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/gradien_background.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/size_config.dart';

class SeePhoto extends StatelessWidget {
  final int id;
  final String findtext;
  const SeePhoto({Key key, this.id, this.findtext}) : super(key: key);

  static Widget of(BuildContext context) => context.ancestorWidgetOfExactType(SeePhoto);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor.withOpacity(.1),
        leading: IconButton(
          icon:   SvgPicture.asset("assets/icons/arrow-long-left.svg", height: SizeConfig.defaultSize*2,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Photo",
          style: TextStyle(fontSize: SizeConfig.defaultSize*2.2, fontWeight: FontWeight.bold),
        ),

      ),
      body: BlocProvider(
        create: (context) => PhotoBloc(),
        child: SeePhotoBody(id: id, findtext: findtext,
        ),
      ),
    );
  }
}

class SeePhotoBody extends StatefulWidget {
  final int id;
  final String findtext;
  const SeePhotoBody({
    Key key, this.id, this.findtext,
  }) : super(key: key);

  @override
  _SeePhotoBodyState createState() => _SeePhotoBodyState();
}

class _SeePhotoBodyState extends State<SeePhotoBody> {
  PhotoBloc _photoBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photoBloc=BlocProvider.of<PhotoBloc>(context);
    _photoBloc.add(SeePhotoEvent(id:widget.id));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackground(),
        BlocBuilder<PhotoBloc,PhotoState>(
          builder: (context, currentState){
            if(currentState is SucceedSeePhotoSate){
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Hero(
                          tag: widget.id,
                          child: FadeInImage.assetNetwork(
                            fadeInCurve: Curves.bounceInOut,
                              placeholder: "assets/gif/spinner.gif",
                              image: currentState.photo.src.large2x,
                            alignment: Alignment.center,
                            height: SizeConfig.defaultSize*55,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(SizeConfig.defaultSize*2),
                        margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize,horizontal: SizeConfig.defaultSize/2),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(SizeConfig.defaultSize*2)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: "Author: ", style: TextStyle(
                                      color: kTextColor,
                                      fontSize: SizeConfig.defaultSize*1.8,
                                      fontWeight: FontWeight.w700,
                                    )),
                                    TextSpan(
                                        text: currentState.photo.photographer, style: TextStyle(color: kTextColor,
                                        fontSize: SizeConfig.defaultSize*1.7, height: 1.5)
                                    )
                                  ]
                              ),
                            ),
                            RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Image Description: ", style: TextStyle(
                                    color: kTextColor,
                                    fontSize: SizeConfig.defaultSize*1.8,
                                    fontWeight: FontWeight.w700,
                                  )),
                                  TextSpan(
                                    text: widget.findtext, style: TextStyle(color: kTextColor,
                                    fontSize: SizeConfig.defaultSize*1.7, height: 1.5)
                                  )
                                ]
                              ),
                            ),
                            RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: "Original Size: ", style: TextStyle(
                                      color: kTextColor,
                                      fontSize: SizeConfig.defaultSize*1.8,
                                      fontWeight: FontWeight.w700,
                                    )),
                                    TextSpan(
                                        text: "${currentState.photo.width} x ${currentState.photo.height}", style: TextStyle(color: kTextColor,
                                        fontSize: SizeConfig.defaultSize*1.7, height: 1.5)
                                    )
                                  ]
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else if(currentState is FailedSeePhotoSate){
              return SizedBox();
            }else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
