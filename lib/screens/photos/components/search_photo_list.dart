import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/screens/components/bottom_loading.dart';
import 'package:virus_total_api/screens/components/flat_custom_button.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/screens/photos/components/photo_card.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';

import '../../../size_config.dart';

class SearchPhotoWidget extends StatefulWidget {
  final String query;

  const SearchPhotoWidget({Key key, this.query}) : super(key: key);
  @override
  _SearchPhotoWidgetState createState() => _SearchPhotoWidgetState();
}

class _SearchPhotoWidgetState extends State<SearchPhotoWidget> {
  PhotoBloc _photoBloc;
  PageController _pageController=PageController();
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photoBloc=BlocProvider.of<PhotoBloc>(context);
    if(widget.query!=""){
      _photoBloc.add(SearchEvent(query: widget.query));
    }
    _pageController.addListener(() {
      if(isLoading) {
        _photoBloc.add(SearchEvent(query: widget.query));
        isLoading=false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, currentstate){
          if(currentstate is LoadingSearchState){
            return LoadingWidget(imageloading: "assets/gif/spinner.gif",);
          }else if(currentstate is SucceedSearchState){
            if(currentstate.photos.isEmpty){
              return OutputText(text: "No photos match to the input",);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize*2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(title: "Total Results",),
                        TitleText(title: "${currentstate.totalresults}",)
                      ],
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: currentstate.reachedPageMax ? currentstate.photos.length : currentstate.photos.length + 1,
                        itemBuilder: (context, index) {
                        if(index == currentstate.photos.length){
                          isLoading=true;
                        }
                        return isLoading ? BottomLoader() : PhotoCard(photo: currentstate.photos[index]);
                        },
                    ),
                  ),
                  // GridView.builder(
                  //     itemCount: currentstate.photos.length,
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: SizeConfig.orientation == Orientation.landscape ? 2:1,
                  //         crossAxisSpacing: SizeConfig.defaultSize,
                  //         mainAxisSpacing: SizeConfig.defaultSize,
                  //         childAspectRatio: 1
                  //     ),
                  //     itemBuilder: (context, index) => PhotoCard(photo: currentstate.photos[index],)
                  // ),
                  currentstate.reachedPageMax ? SizedBox(): Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: SizeConfig.defaultSize*2, right: SizeConfig.defaultSize*2),
                      child: FlatCustomButton(buttontext: "Next page", press: (){
                        _photoBloc.add(SearchEvent(query: widget.query));
                      },),
                    ),
                  ),
                ],
              ),
            );
          }else if(currentstate is FailSearchState){
            return OutputText(text: "Please check your internet connection",);
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
