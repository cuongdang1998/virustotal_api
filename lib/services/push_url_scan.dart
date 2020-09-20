import 'dart:io';

import 'package:dio/dio.dart';
import 'package:virus_total_api/models/push_url_scan.dart';

Future<int> pushUrlScan(String urlresource) async{
  Dio dio=Dio();
  Response response;
  final String url="https://www.virustotal.com/vtapi/v2/url/scan";
  final String keyApi="a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
  try{
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    response= await dio.post(url,
        data:{'apikey':keyApi, 'url':urlresource},);
    if(response.statusCode==200){
      var a=PushUrlScan.fromJson(response.data);
      return a.responsecode;
    }else{
      throw("Error status code in pushUrlScan");
    }
  }catch(exception){
    throw("=======Error in pushUrlScan method ====== "+exception.toString());
  }
}