import 'package:dio/dio.dart';
import 'package:virus_total_api/models/url_scan.dart';
import 'package:virus_total_api/models/url_scan_report.dart';

class FetchUrlScanReport{
  Response response;
  Dio dio=Dio();
  final String urlApi="https://www.virustotal.com/vtapi/v2/url/report?";
  final String apiKey="a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
  static String urlResource="";
  Future<UrlScanReport> fetchUrlScanReport() async {
    try {
      response = await dio.get(urlApi + "apikey=" + apiKey + "&resource=" + urlResource);
      if(response.statusCode==200){
        var urlScanReport= UrlScanReport.fromJson(response.data);
        return urlScanReport;
      }else{
        print("\nError status code in fetchUrlScanReport\n");
      }
    }catch(exception){
      throw("\nError in fetchUrlScanReport====== "+exception.toString());
    }
  }
  Future<List<UrlScan>> fetchUrlScanList() async{
    try{
      List<UrlScan> scans=List<UrlScan>();
      var urlScanReport = await fetchUrlScanReport();
      for(var s in urlScanReport.urlScans.values.toList()){
        scans.add(s);
      }
      return scans;
    }catch(exception){
      throw("\nError in fetchUrlScanList: "+exception.toString());
    }
  }
}