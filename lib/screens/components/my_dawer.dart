import 'package:flutter/material.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/components/title_text.dart';
import 'package:virus_total_api/size_config.dart';
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: SizeConfig.defaultSize*4, bottom: SizeConfig.defaultSize),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kPrimaryColor.withOpacity(.2),
                    kPrimaryColor.withOpacity(.5)
                  ]
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                    radius: SizeConfig.defaultSize*4,
                  ),
                  TitleText(title:"Quốc Cường")
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListTile(
              title: FlatButton(
                child: Text("Menu 1"),
                onPressed: (){},
              ),
              leading: Text("1"),
              trailing: Icon(Icons.comment),
            ),
          )
        ],
      ),
    );
  }
}
