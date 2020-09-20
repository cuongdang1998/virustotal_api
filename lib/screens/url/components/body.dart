import 'package:flutter/material.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/alert_dialog.dart';
import 'package:virus_total_api/screens/components/input_container.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/services/fetch_url_scan_report.dart';
import 'package:virus_total_api/services/push_url_scan.dart';

import '../../../size_config.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var urlTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:defaultSize*2, vertical: defaultSize),
            child: TitleText(title: "Input Your URL",),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultSize*2, vertical: defaultSize),
            child: InputAndScanButton(urlTextController: urlTextController),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:defaultSize*2, vertical: defaultSize),
            child: TitleText(title: "Scan URL Report",),
          ),

        ],
      ),
    );
  }
}

class InputAndScanButton extends StatelessWidget {
  const InputAndScanButton({
    Key key,
    @required this.urlTextController,
  }) : super(key: key);

  final TextEditingController urlTextController;
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: InputContainer(hinttext: "Input url link", myController: urlTextController,)),
        SizedBox(width: defaultSize,),
        FlatButton(
          onPressed: () async{
            var text= urlTextController.text;
            print(text);
            if(text==""||text==null) {
              showAlertDialogWithOneButton(
                context: context,
                title: "Input Url",
                icon: Icons.report_problem,
                content: "Please input the url you want to scan !",
                buttontext: "OK",
                size: defaultSize
              );
            }else{
              FetchFileScanReport scanReport=FetchFileScanReport();
              FetchFileScanReport.fileResource=text;
              var a =await scanReport.fetchFileScanList();
              // FetchUrlScanReport scanReport= FetchUrlScanReport();
              // FetchUrlScanReport.urlResource=text;
              // var a= await scanReport.fetchUrlScanList();
              print(a);
              //print(a[0].keyname);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultSize*2),
          ),
          color: kPrimaryColor,
          child: Text("Scan",style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.bold,color: Colors.white
          ),),
        )
      ],
    );
  }
}
