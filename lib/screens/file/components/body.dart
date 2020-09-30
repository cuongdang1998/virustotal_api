import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/input_container.dart';
import 'package:virus_total_api/screens/components/loading.dart';
import 'package:virus_total_api/screens/components/output_text.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/screens/file/components/scan_card_list.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScanFileBloc _scanfilebloc;
  var defaultSize=SizeConfig.defaultSize;
  final _inputFileController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scanfilebloc=BlocProvider.of<ScanFileBloc>(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _inputFileController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    FetchFileScanReport.fileResource="";
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize*2.0, vertical: defaultSize*1.0),
              child: TitleText(title: "Input Your File",),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize*2, vertical: defaultSize),
              child: Row(
                children: [
                  Expanded(child: InputContainer(hinttext: "Input file resource", myController: _inputFileController,)),
                  SizedBox(width: defaultSize/2,),
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/scan.svg", color: kTextColor, width: defaultSize*2.5,),
                    onPressed: (){
                      var input=_inputFileController.text;
                      //print(text);
                      if(input=="" || input==null){
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(defaultSize*2),
                                  topRight: Radius.circular(defaultSize*2)
                                )
                              ),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue.withOpacity(.8),
                              content: ListTile(
                                leading: Icon(Icons.warning, color: Colors.white, size: defaultSize*3,),
                                title: Text("Hey man, please input your file !",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: defaultSize*1.8
                                  ),

                                ),
                              ),
                            )
                        );
                      }else if(FetchFileScanReport.fileResource!=input){
                        FetchFileScanReport.fileResource=input;
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize*2.0),
              child: BlocBuilder<ScanFileBloc, FileScanState>(
                  builder: (context, state){
                    var currentState=state;
                    // Trạng thái ban đầu
                    if(currentState is InitialFileScanState){
                      return OutputText(text: "Please input your file resource !",);
                    }
                    //Loading chờ dữ liệu
                    if(currentState is LoadingFileScanState){
                      return LoadingWidget(imageloading:"assets/gif/spinner.gif");
                    }
                    //Fetch dữ liệu thành công
                    if(currentState is SucceededFileScanState){
                      if(currentState.scans.isEmpty)
                        return OutputText(text: "Scan file information is empty",);
                      return ScanCardList(scans: currentState.scans);
                    }
                    //Lấy dữ liệu thất bại
                    if(currentState is FailedFileScanState){
                      return OutputText(text: "Please check your internet connection !\n"
                          "Or your file input is NOT in dataset !",);
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
