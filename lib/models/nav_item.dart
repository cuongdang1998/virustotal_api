import 'package:flutter/cupertino.dart';
class NavItem{
  //final int id;
  final String icon;
  final String targetScreen;

  NavItem({this.icon, this.targetScreen});
  // bool targetScreenChecker(){
  //   if(targetScreen!=null){
  //     return true;
  //   }
  //   return false;
  // }
}
class NavItems with ChangeNotifier{
  int selectedIndex=0;
  void changNavIndex({int index}){
    selectedIndex=index;
    notifyListeners();
  }
  List<NavItem> navlist=[
    NavItem(
      //id:1,
      icon: "assets/icons/file.svg",
      targetScreen: "/"
    ),
    NavItem(
        //id:2,
        icon: "assets/icons/url.svg",
        targetScreen: "/url"
    ),
    NavItem(
        //id:3,
        icon: "assets/icons/comment.svg",
        targetScreen: "/comment"
    ),
    NavItem(
      //id:4,
        icon: "assets/icons/image.svg",
        targetScreen: "/photo"
    ),
  ];
}