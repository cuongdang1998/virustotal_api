import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/models/file_scan_report.dart';

class FetchFileScanReport{
  final String urlFileScanReport="https://www.virustotal.com/vtapi/v2/file/report?";
  final String keyApi="a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
  static String fileResource;
  Response response;
  Dio dio= Dio();
  Future<FileScanReport> fetchFileScanReport() async{
    try{
      response=await dio.get(urlFileScanReport+"apikey="+keyApi+"&resource="+fileResource);
      if(response.statusCode==200){
        var fileReport=FileScanReport.fromJson(response.data);
        return fileReport;
      }else{
        throw('\nResponse error in fetchFileScanReport');
      }
    }catch(ex){
      print("\nError in fetchFileScanReport "+ex.toString());
    }
  }
  Future<List<FileScan>> fetchFileScanList() async{
    try{
      var fileReport =await fetchFileScanReport();
      List<FileScan> list=List<FileScan>();
      for(var f in fileReport.filescans.values.toList()){
            print(f.keyscan);
            list.add(f);
          }
      return list;
    }catch(e){
      throw("\nError in fetchFileScanList"+e.toString());
    }
  }
}