import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/screens/comment/comment_screen.dart';
import 'package:virus_total_api/screens/comment/create_comment_screen.dart';
import 'package:virus_total_api/screens/file/file_home_screen.dart';
import 'package:virus_total_api/screens/photos/photo_screen.dart';
import 'package:virus_total_api/screens/photos/see_a_photo_screen.dart';
import 'package:virus_total_api/screens/url/url_screen.dart';

class FluroRouter{
  static Router router=Router();
  // Navigator Handler
  Handler fileHandler=Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> param){
      return FileHomeScreen();
    }
  );
  Handler urlHandler=Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param){
        return UrlScreen();
      }
  );
  Handler commentHandler=Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param){
        return CommentScreen();
      }
  );
  Handler photoHandler=Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param){
        return PhotoScreen();
      }
  );

  //Other Navigator
  Handler createCommentHandler=Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param){
        return CreateCommentScreen();
      }
  );
  Handler seePhotoHandler=Handler(
      handlerFunc: (BuildContext context, Map<dynamic, dynamic> param){
        return SeePhoto(
          id: int.parse(param['id'][0]),
        );
      }
  );
  void setRouter(){
    // Navigator Router
    router.define('/', handler: fileHandler, transitionType: TransitionType.fadeIn);
    router.define('/url', handler: urlHandler, transitionType: TransitionType.fadeIn);
    router.define('/comment', handler: commentHandler, transitionType: TransitionType.fadeIn);
    router.define('/photo', handler: photoHandler, transitionType: TransitionType.fadeIn);
    //Other Router
    router.define('/createcomment', handler: createCommentHandler, transitionType: TransitionType.fadeIn);
    router.define('/seephoto/:id', handler: seePhotoHandler, transitionType: TransitionType.fadeIn);

  }
}