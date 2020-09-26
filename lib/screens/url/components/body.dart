import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/custom_app_bar.dart';
import 'package:virus_total_api/screens/components/header_shape_color.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/screens/url/components/url_scan_card.dart';
import 'package:virus_total_api/services/url_scan_service.dart';

import '../../../size_config.dart';
import 'input_and_scan_button.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _urlTextController=TextEditingController();
  UrlScanBloc _urlScanBloc;
  @override
  void initState() {
    super.initState();
    UrlScanService.urlResource="";
    _urlScanBloc=BlocProvider.of<UrlScanBloc>(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _urlTextController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Stack(
      children: [
        HeaderShapeColor(),
        SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                icon: "assets/icons/menu.svg",
                text: "Scan URL",
                iconsize: defaultSize*2,
                press: (){
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:defaultSize*2, vertical: defaultSize),
                        child: TitleText(title: "Input Your URL",),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: defaultSize*2, vertical: defaultSize),
                        child: InputAndScanButton(urlTextController: _urlTextController,
                          scanBloc: _urlScanBloc,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: defaultSize*2),
                        child: Divider(thickness: 2, color: kPrimaryColor.withOpacity(.2),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:defaultSize*2, vertical: defaultSize*2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(title: "Scan URL Report",),
                            BlocBuilder<UrlScanBloc, UrlScanState>(
                                builder:(context,currentState) {
                                  if(currentState is SucceedScanUrlState){
                                    return TitleText(title:"${currentState.urlScanReport.total}");
                                  }else{
                                    return TitleText(title:"0");
                                  }
                                }
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: defaultSize*2, right: defaultSize*2, bottom: defaultSize*2),
                        child: BlocBuilder<UrlScanBloc, UrlScanState>(
                           builder:(context, currentstate) {
                             if(currentstate is InitialScanUrlState){
                               return OutputText(text: "Please input your URL!",);
                             }
                             if(currentstate is LoadingScanUrlState){
                               return LoadingWidget(imageloading: "assets/gif/ripple.gif",);
                             }
                             if(currentstate is SucceedScanUrlState){
                               if(currentstate.urlScan.isEmpty){
                                 return OutputText(text:"Scan information is empty !");
                               }
                               return GridView.builder(
                                   shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemCount: currentstate.urlScan.length,
                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                       crossAxisCount: SizeConfig.orientation ==
                                           Orientation.landscape ? 2 : 1,
                                       childAspectRatio: 2.1,
                                       mainAxisSpacing: defaultSize * 2,
                                       crossAxisSpacing: defaultSize * 2
                                   ),
                                   itemBuilder: (context, index) => UrlScanCard(urlScan:currentstate.urlScan[index])
                               );
                             }
                             if(currentstate is FailedScanUrlState){
                               return OutputText(text: "Some errors:\nPlease check your internet connection"
                                   "\nYour input url is not correct"
                                   "\nServer is busy now !",);
                             }
                           }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}