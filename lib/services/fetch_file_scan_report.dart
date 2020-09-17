import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/models/file_scan_report.dart';

class FetchFileScanReport{
  final String urlFileScanReport="https://www.virustotal.com/vtapi/v2/file/report?";
  final String keyApi="a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
  final String resource="99017f6eebbac24f351415dd410d522d";
  Response response;
  Dio dio= Dio();
  Future<FileScanReport> fetchFileScanReport() async{
    response=await dio.get(urlFileScanReport+"apikey="+keyApi+"&resource="+resource);
    if(response.statusCode==200){
      var a=FileScanReport.fromJson(response.data);
      return a;
    }
  }
  Future<List<Scan>> fetchFileScanList() async{
    response=await dio.get(urlFileScanReport+"apikey="+keyApi+"&resource="+resource);
    List<Scan> list=List<Scan>();
    if(response.statusCode==200){
      var a=FileScanReport.fromJson(response.data);
      for(var i in a.scans.values.toList()){
        //print(i.keyscan);
        list.add(i);
      }
      //print(list);
      //Future.delayed(Duration(seconds: 5));
      return list;
    }
  }
}