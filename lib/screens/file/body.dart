import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/blocs/scan_bloc.dart';
import 'package:virus_total_api/events/scan_event.dart';
import 'package:virus_total_api/screens/file/scan_card_list.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/states/scan_state.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScanBloc _scanbloc;
  @override
  void initState() {
    super.initState();
    _scanbloc=BlocProvider.of<ScanBloc>(context);
    //_scanbloc.add(FetchScanReportEvent());
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: RaisedButton(
              onPressed: (){
                if(FetchFileScanReport.resource!=null) {
                  _scanbloc.add(FetchScanReportEvent());
                }else{
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.blue,
                      content: Text("Please input your file", style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20
                      ),),
                    )
                  );
                }
              },
              child: Text("Scan", style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
              color: Colors.blue.withOpacity(.7),
            ),
          ),
         BlocBuilder<ScanBloc, ScanState>(
                builder: (context, state){
                  var currentState=state;
                  if(currentState is InitialScanState){
                    return Center(child: Image.asset("assets/gif/spinner.gif"),);
                  }
                  if(currentState is SucceededScanState){
                    if(currentState.scans.isEmpty)
                      return Center(child: Text("NO detected file information"),);
                    return ScanCardList(scans: currentState.scans);
                  }
                  if(currentState is FailedScanState){
                    return Center(child: Text("Please check your intenet connection or your input file"),);
                  }
                }
          ),
        ],
      ),
    );
  }
}
