import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/blocs/url_scan_bloc.dart';
import 'package:virus_total_api/bloc/events/url_scan_event.dart';
import 'package:virus_total_api/bloc/states/url_scan_state.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/screens/url/components/url_scan_card.dart';

import '../../../size_config.dart';
import 'input_and_scan_button.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var urlTextController=TextEditingController();
  UrlScanBloc _urlScanBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _urlScanBloc=BlocProvider.of<UrlScanBloc>(context);

  }
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:defaultSize*2, vertical: defaultSize),
              child: TitleText(title: "Input Your URL",),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize*2, vertical: defaultSize),
              child: InputAndScanButton(urlTextController: urlTextController,
                scanBloc: _urlScanBloc,
              ),
            ),
            Divider(thickness: 2, color: kPrimaryColor.withOpacity(.2),),
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
                     return OutputText(text: "Please check your internet connection\n"
                         "Or your input url is not in the dataset",);
                   }
                 }
              ),
            )
          ],
        ),
      ),
    );
  }
}

