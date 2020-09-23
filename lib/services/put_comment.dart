import 'package:dio/dio.dart';

class PutComments{
  static String resource="";
  static String comment="";
  Future<String> putComment() async{
    Dio dio=Dio();
    Response response;
    final String apikey="a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
    final String url="https://www.virustotal.com/vtapi/v2/comments/put";

    try{
      FormData formData=FormData.fromMap(
          {"apikey": apikey,
            "resource": resource,
            "comment":comment
          }
      );
      response=await dio.post(url, data: formData);
      if(response.statusCode==200){
        var a=response.data;
        //print(a["verbose_msg"]);
        return a["verbose_msg"];
      }else{
        throw("======Error in response======");
      }
    }catch(exception){
      throw("=======Error in putComment ====="+ exception.toString());
    }
  }
}