import 'package:dio/dio.dart';
import 'package:virus_total_api/models/photos/curated_photo.dart';
import 'package:virus_total_api/models/photos/photo.dart';
import 'package:virus_total_api/models/photos/search_photo.dart';

Future<List<Photo>> fetchPhoto(int page) async{
  Dio _dio=Dio();
  Response _response;
  final String _apikey="563492ad6f91700001000001f48fd04f99974825a103752e21dc5839";
  _dio.options.headers["authorization"]=_apikey;
  List<Photo> _listphoto=List<Photo>();
  CuratedPhoto curatedphoto;

  try{
    _response= await _dio.get("https://api.pexels.com/v1/curated?page=${page}&per_page=30");
    if(_response.statusCode==200){
      curatedphoto= CuratedPhoto.fromJson(_response.data);
      for(var p in curatedphoto.photos.toList()){
        _listphoto.add(p);
      }
    }
  }catch(exception){
    throw("Error in fetchPhotos=========" + exception.toString());
  }
  return _listphoto;
}
//Xem 1 photo
Future<Photo> getAPhoto(int photoid) async{
  Dio _dio=Dio();
  Response _response;
  final String _apikey="563492ad6f91700001000001f48fd04f99974825a103752e21dc5839";
  _dio.options.headers["authorization"]=_apikey;

  try{
    _response= await _dio.get("https://api.pexels.com/v1/photos/${photoid}");
    if(_response.statusCode==200){
      var photo= Photo.fromJson(_response.data);
      return photo;
    }
  }catch(exception){
    throw("Error in fetchPhotos=========" + exception.toString());
  }
}
//Search photo
Future<SearchPhoto> fetchSearchPhoto(String query, int page) async{
  Dio _dio=Dio();
  Response _response;
  final String _apikey="563492ad6f91700001000001f48fd04f99974825a103752e21dc5839";
  _dio.options.headers["authorization"]=_apikey;
  try{
    _response= await _dio.get("https://api.pexels.com/v1/search?page=${page}&query=${query}&per_page=10");
    if(_response.statusCode==200){
      var photo= SearchPhoto.fromJson(_response.data);
      return photo;
    }
  }catch(exception){
    throw("Error in fetchPhotos=========" + exception.toString());
  }
}
//Search more on button next page
// Future<SearchPhoto> fetchSearchPhotoNextPage(String nextPage) async{
//   Dio _dio=Dio();
//   Response _response;
//   final String _apikey="563492ad6f91700001000001f48fd04f99974825a103752e21dc5839";
//   _dio.options.headers["authorization"]=_apikey;
//   try{
//     _response= await _dio.get(nextPage);
//     if(_response.statusCode==200){
//       var searchphoto= SearchPhoto.fromJson(_response.data);
//
//       return searchphoto;
//     }
//   }catch(exception){
//     throw("Error in fetchPhotos=========" + exception.toString());
//   }
// }