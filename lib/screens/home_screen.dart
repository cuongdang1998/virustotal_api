import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/blocs/scan_bloc.dart';
import 'package:virus_total_api/events/scan_event.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';

import 'file/body.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scan File"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RaisedButton(
                  onPressed: (){
                    FetchFileScanReport.resource="477e691b924ea44e67dc7c7c5fa37465";
                  },
                  child: Text("Get resource ", style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
                  color: Colors.blue.withOpacity(.7),
                ),
                BlocProvider(
                  create: (context) => ScanBloc(),
                  child: Body(),
                ),
              ],
            ),
          ),
        )
    );
  }
}