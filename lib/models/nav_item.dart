import 'package:flutter/cupertino.dart';
import 'package:virus_total_api/screens/file/file_home_screen.dart';
import 'package:virus_total_api/screens/url/url_screen.dart';

class NavItem{
  final int id;
  final String icon;
  final Widget targetScreen;

  NavItem({this.id, this.icon, this.targetScreen});
  bool targetScreenChecker(){
    if(targetScreen!=null){
      return true;
    }
    return false;
  }
}
class NavItems with ChangeNotifier{
  int selectedIndex=0;
  void changNavIndex({int index}){
    selectedIndex=index;
    notifyListeners();
  }
  List<NavItem> navlist=[
    NavItem(
      id:1,
      icon: "assets/icons/file.svg",
      targetScreen: FileHomeScreen()
    ),
    NavItem(
        id:2,
        icon: "assets/icons/url.svg",
        targetScreen: UrlScreen()
    ),
  ];
}