import 'package:flutter/material.dart';
import 'package:virus_total_api/models/file_scan.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
class ScanCard extends StatelessWidget {
  const ScanCard({
    Key key,
    @required this.scan, this.index,
  }) : super(key: key);

  final FileScan scan;
  final int index;

  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Container(
      margin: EdgeInsets.symmetric(vertical: defaultSize),
      padding: EdgeInsets.symmetric(vertical: defaultSize, horizontal: defaultSize*2),
      width: double.infinity,
      decoration: BoxDecoration(
          color: index.isEven ? Colors.white : kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0,4),
                color: kTextColor.withOpacity(.1),
                blurRadius: 20
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(scan.keyscan, style: TextStyle(
                color: index.isEven ? kTextColor: Colors.white,
                fontWeight: FontWeight.bold, fontSize: defaultSize*1.8),),
          ),
          SizedBox(height: defaultSize/2,),
          RichText(
            text: TextSpan(
                children: [
                  TextSpan(text: "Result: ",style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: defaultSize*1.5,
                      color:index.isEven ? kTextColor : Colors.white)
                  ),
                  TextSpan(text:scan.result ?? "",style: TextStyle(fontSize: defaultSize*1.5,
                      color: index.isEven ? kTextColor : Colors.white)
                  ),
                ]
            ),
          ),
          SizedBox(height: defaultSize/2,),
          RichText(
            text: TextSpan(
                children: [
                  TextSpan(text: "Version: ",style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: defaultSize*1.5,
                      color: index.isEven ? kTextColor : Colors.white)
                  ),
                  TextSpan(text:scan.version ?? "",style: TextStyle(fontSize: defaultSize*1.5,
                      color: index.isEven ? kTextColor : Colors.white)
                  ),
                ]
            ),
          ),
          Align(
            child: scan.detected ? Icon(
              Icons.thumb_up, size: defaultSize*3.5,
              color:index.isEven ? kPrimaryColor: Colors.white,) : Icon(
              Icons.thumb_down, size: defaultSize*3.5,
              color:index.isEven ? kPrimaryColor: Colors.white,),
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }
}