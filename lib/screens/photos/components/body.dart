import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/screens/components/bottom_loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/photos/components/photo_card.dart';
import 'package:virus_total_api/size_config.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PhotoBloc _photoBloc;

  @override
  void initState(){
    super.initState();
    _scrollController.addListener(_onScroll);
    _photoBloc=BlocProvider.of<PhotoBloc>(context);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _photoBloc.add(FetchPhotoEvent());
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PhotoBloc,PhotoState>(
        builder: (context, currentState){
          if(currentState is InitialFetchPhotoState){
            return SizedBox();
          }
          if(currentState is SucceedFetchPhotoState){
            if(currentState.photos.isEmpty){
              return Center(child: OutputText(text: "No photos here",));
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
              child: Scrollbar(
                isAlwaysShown: true,
                controller:  _scrollController,
                child: GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: currentState.hasReachedMax ? currentState.photos.length : currentState.photos.length+1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SizeConfig.orientation ==Orientation.landscape ? 2:1,
                      childAspectRatio: 1 ,
                      mainAxisSpacing: SizeConfig.defaultSize,
                      crossAxisSpacing: SizeConfig.defaultSize
                  ),
                  itemBuilder: (context, index) => index >=currentState.photos.length ? BottomLoader():
                  PhotoCard(photo: currentState.photos[index],),
                ),
              ),
            );
          }
          if(currentState is FailedFetchPhotoState){
            return Center(child: OutputText(text: "Can not get photos. Check intenet connection !",));
          }
        },
      ),
    );
  }
}