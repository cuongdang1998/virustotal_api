import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: SeePhotoBody(id: id, findtext: findtext, ),
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<PhotoBloc,PhotoState>(
              builder: (context, currentState){
                if(currentState is SucceedSeePhotoSate){
                  return Center(
                    child: Hero(
                      tag: widget.id,
                      child: FadeInImage.assetNetwork(
                        fadeInCurve: Curves.bounceInOut,
                          placeholder: "assets/gif/spinner.gif",
                          image: currentState.photo.src.large,
                        alignment: Alignment.center,
                        height: SizeConfig.defaultSize*50,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
            Text("${widget.findtext}")
          ],
        ),
      ),
    );
  }
}
