import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/bloc/blocs/file_scan_bloc.dart';
import 'package:virus_total_api/bloc/events/file_scan_event.dart';
import 'package:virus_total_api/screens/components/input_container.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/screens/file/components/scan_card_list.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/size_config.dart';
import 'package:virus_total_api/bloc/states/file_scan_state.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScanFileBloc _scanfilebloc;
  var defaultSize=SizeConfig.defaultSize;
  final inputFileController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scanfilebloc=BlocProvider.of<ScanFileBloc>(context);
    //_scanbloc.add(FetchScanReportEvent());
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultSize*2.0, vertical: defaultSize*1.0),
                child: TitleText(title: "Input your file",),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultSize*2, vertical: defaultSize),
                child: Row(
                  children: [
                    Expanded(child: InputContainer(hinttext: "Input file resource", myController: inputFileController,)),
                    SizedBox(width: defaultSize/2,),
                    IconButton(
                      icon: SvgPicture.asset("assets/icons/scan.svg", width: defaultSize*2.5,),
                      onPressed: (){
                        var text=inputFileController.text;
                        print(text);
                        if(text=="" || text==null){
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.blue,
                                content: ListTile(
                                  leading: Icon(Icons.warning, color: Colors.white,),
                                  title: Text("Please input your file !",
                                    overflow: TextOverflow.ellipsis,
                                    //maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: defaultSize*1.8
                                    ),

                                  ),
                                ),
                              )
                          );
                        }else{
                          FetchFileScanReport.resource=text;
                          _scanfilebloc.add(FetchFileScanReportEvent());
                          //ScanFileBloc(InitialScanState());
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultSize*2.0, vertical: defaultSize*1.0),
                child: TitleText(title: "File Scan Report",),
              ),
              BlocBuilder<ScanFileBloc, FileScanState>(
                  builder: (context, state){
                    print(state);
                    var currentState=state;
                    if(currentState is InitialScanState){
                      print(currentState);
                      return Center(child: Image.asset("assets/gif/spinner.gif"),);
                    }
                    if(currentState is SucceededScanState){
                      print(currentState);
                      if(currentState.scans.isEmpty)
                        return Center(child: Text("NO detected file information"),);
                      return ScanCardList(scans: currentState.scans);
                    }
                    if(currentState is FailedScanState){
                      print(currentState);
                      return Center(
                        child: Text("Please check your internet connection !\n"
                            "Or your file input is NOT in dataset !"),
                      );
                      //AlertDialog(
                      //       title: Text("Infomation", style: TextStyle(fontWeight: FontWeight.bold),),
                      //       content: Text("Please check your internet connection !\n"
                      //           "Or your file input is NOT in dataset !",
                      //         style: TextStyle(fontSize: defaultSize*1.5),),
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: defaultSize*1.5, horizontal: defaultSize*4,
                      //       ),
                      //       actions: [
                      //         Builder(
                      //           builder: (context) {
                      //             return FlatButton(
                      //               onPressed: (){
                      //                 Navigator.of(context, rootNavigator: false).pop();
                      //               },
                      //               child: Text("OK",
                      //                 style: TextStyle(fontSize: defaultSize*2,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             );
                      //           }
                      //         )
                      //       ],
                      //     );
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

}