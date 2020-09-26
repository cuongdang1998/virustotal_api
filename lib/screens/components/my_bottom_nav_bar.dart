import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/models/nav_item.dart';
import 'package:virus_total_api/size_config.dart';
class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    var defaultsize=SizeConfig.defaultSize;
    return Consumer<NavItems>(
      builder: (context, navItems, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: defaultsize*2),
        height: defaultsize*8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultsize*3),
            topRight: Radius.circular(defaultsize*3)
          ),
          boxShadow: [
            BoxShadow(
              color: kTextColor.withOpacity(.1),
              offset: Offset(0,-4),
              blurRadius: 20
            )
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(navItems.navlist.length, (index) =>
              buildNavBarItem(
                icon: navItems.navlist[index].icon,
                size: defaultsize,
                isActive:  navItems.selectedIndex == index ? true : false,
                press: (){
                  if(navItems.selectedIndex!=index){
                    navItems.changNavIndex(index:  index);
                    Navigator.pushNamed(context, navItems.navlist[index].targetScreen);
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => navItems.navlist[index].targetScreen
                    // ));
                  }
                }
              )
          )
        ),
      ),
    );
  }
  IconButton buildNavBarItem({Function press,String icon, double size, bool isActive=false}) {
    return IconButton(
       onPressed: press,
       icon: SvgPicture.asset(
       icon,
       height: isActive ? size*3.5: size*2.3,
       color: isActive ? kPrimaryColor : kTextColor,
       ),
    );
  }
}
