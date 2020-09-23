import 'package:dio/dio.dart';
import 'package:virus_total_api/models/comments.dart';

class FetchComments{
  Dio dio=Dio();
  Response response;
  final String keyapi="a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
  final String url="https://www.virustotal.com/vtapi/v2/comments/get";
  static String resource="";
  Future<List<Comment>> fetchComments() async{
    try{
      response = await dio.get(url+"?apikey="+keyapi+"&resource="+resource);
      if(response.statusCode==200){
        List<Comment> listcomment;
        var a=Comments.fromJson(response.data);
        listcomment=a.comments;
        return listcomment;
      }else{
        print("Error response in FetchComments");
      }
    }catch(exception){
      throw("Error in FetchComments===="+exception.toString());
    }

  }
}